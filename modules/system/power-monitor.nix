{ pkgs, ... }:

let
    powerMonitorScript = pkgs.writeShellScriptBin "power-monitor" ''
        #!/bin/bash
        
        # Function to safely check if connected to AC power using bash built-ins (no forks)
        is_charging() {
            for ps in /sys/class/power_supply/*; do
                if [ -f "$ps/type" ]; then
                    read -r type < "$ps/type"
                    if [ "$type" = "Mains" ]; then
                        read -r online < "$ps/online"
                        if [ "$online" -eq 1 ]; then
                            return 0 # True, it is charging
                        else
                            return 1 # False, it is discharging
                        fi
                    fi
                fi
            done
            return 1 # Default to false if nothing is found
        }

        # 1. Initial Check: If discharging at boot, exit completely for this session.
        if ! is_charging; then
            exit 0
        fi

        SHUTDOWN_PENDING=0

        # 2. Adaptive Loop Check
        while true; do
            if is_charging; then
                # We have power. Cancel shutdown if one was pending.
                if [ "$SHUTDOWN_PENDING" -eq 1 ]; then
                    /run/current-system/sw/bin/shutdown -c
                    SHUTDOWN_PENDING=0
                fi
                
                # Safe state: sleep for 180 seconds
                sleep 180
            else
                # We lost power. Trigger shutdown if not already triggered.
                if [ "$SHUTDOWN_PENDING" -eq 0 ]; then
                    /run/current-system/sw/bin/shutdown +2 "AC disconnected. Shutting down in 2 minutes."
                    SHUTDOWN_PENDING=1
                fi
                
                # High-alert state: sleep for only 5 seconds to catch reconnection
                sleep 5
            fi
        done
    '';
in

{
    systemd.services.power-monitor = {
        description = "Monitor AC Power and Shutdown on Disconnect";
        after = [ "multi-user.target" ];
        wantedBy = [ "multi-user.target" ];
        
        serviceConfig = {
            Type = "simple";
            ExecStart = "${powerMonitorScript}/bin/power-monitor";
            Restart = "no";
        };
    };
}
