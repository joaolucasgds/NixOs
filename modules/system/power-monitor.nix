{ pkgs, ... }:

let
    powerMonitorScript = pkgs.writeShellScriptBin "power-monitor" ''
        #!/bin/bash
        # Function to safely check if connected to AC power
        is_charging() {
            # Loop through power supplies to find the main AC adapter
            for ps in /sys/class/power_supply/*; do
                if [ -f "$ps/type" ] && [ "$(cat "$ps/type")" = "Mains" ]; then
                    if [ "$(cat "$ps/online")" -eq 1 ]; then
                        return 0 # True, it is charging
                    else
                        return 1 # False, it is discharging
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

        # 2. Loop Check: Keep checking as long as the machine is on
        while true; do
            if ! is_charging; then
                # 3. Trigger Shutdown: If discharging and no shutdown is pending
                if [ "$SHUTDOWN_PENDING" -eq 0 ]; then
                    shutdown +2 "AC disconnected. Shutting down in 2 minutes."
                    SHUTDOWN_PENDING=1
                fi
            else
                # 4. Cancel Shutdown: If charge detected again while waiting to shutdown
                if [ "$SHUTDOWN_PENDING" -eq 1 ]; then
                    shutdown -c
                    SHUTDOWN_PENDING=0
                fi
            fi
            
            # Wait 3 minutes before checking again
            sleep 180
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

