{ pkgs, config, hostvars, ... }:

let
    baseSettings = {
        # --- Wallpaper ---
        wallpaper = {
            directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
        };
        wallpaperFillMode = "Fill";

        # --- Theming & Visuals ---
        currentThemeName = "dynamic";
        matugenScheme = "scheme-vibrant";
        widgetColorMode = "colorful";

        # --- Launcher Logo ---
        launcherLogoMode = "os";
        launcherLogoCustomPath = "";
        launcherLogoColorOverride = "primary";
        launcherLogoColorInvertOnMode = false;
        launcherLogoBrightness = 0.5;
        launcherLogoContrast = 1;
        launcherLogoSizeOffset = 8;

        # --- System & Units ---
        windSpeedUnit = "ms";
        use24HourClock = false;

        # --- Cursor ---
        cursorSettings = {
            theme = "Adwaita";
            size = 24;
            niri = {
                hideWhenTyping = false;
                hideAfterInactiveMs = 0;
            };
            hyprland = {
                hideOnKeyPress = false;
                hideOnTouch = false;
                inactiveTimeout = 0;
            };
            dwl = {
                cursorHideTimeout = 0;
            };
        };

        # --- Bar Configuration ---
        barConfigs = [
            {
                id = "default";
                name = "Main Bar";
                enabled = true;
                position = 0;
                transparency = 0;
                
                # These will be dynamically overwritten by the script, 
                # but i am leaving them here for a clean template structure.
                showOnLastDisplay = false; 
                screenPreferences = [];

                leftWidgets = [
                    "launcherButton"
                    "workspaceSwitcher"
                    {
                        id = "focusedWindow";
                        enabled = true;
                        focusedWindowCompactMode = true;
                    }
                    {
                        id = "dankKDEConnect";
                        enabled = true;
                    }
                ];

                centerWidgets = [
                    "music"
                    "clock"
                    "weather"
                ];

                rightWidgets = [
                    { id = "privacyIndicator"; enabled = true; }
                    { id = "cpuUsage"; enabled = true; }
                    { id = "memUsage"; enabled = true; }
                    { id = "notificationButton"; enabled = true; }
                    { id = "battery"; enabled = true; }
                    { id = "controlCenterButton"; enabled = true; }
                ];
            }
        ];
    };
in
{
    home.file.".config/DankMaterialShell/settings-template.json".text = builtins.toJSON baseSettings;

    systemd.user.services.dms-monitor-fix = {
        Unit = {
            Description = "Merge Nix template with runtime monitor port for DMS";
            Before = [ "dms.service" ];
            PartOf = [ "dms.service" ];
        };

        Install = {
            WantedBy = [ "dms.service" ];
        };

        Service = {
            Type = "oneshot";
            
            # Hardening 
            NoNewPrivileges = true;
            PrivateTmp = true;
            ProtectSystem = "strict";
            ProtectHome = "read-only";
            ReadWritePaths = [ "%h/.config/DankMaterialShell" ];

            ExecStart = "${pkgs.writeShellScript "dms-inject" ''
                TARGET_MODEL="${hostvars.primaryMonitorModel}"
                DEFAULT_MODEL="${hostvars.defaultMonitorModel}"
                
                TEMPLATE="$HOME/.config/DankMaterialShell/settings-template.json"
                REAL_SETTINGS="$HOME/.config/DankMaterialShell/settings.json"

                # 1. Ask Hyprland if the PRIMARY monitor is plugged in
                PORT_NAME=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r ".[] | select(.model == \"$TARGET_MODEL\") | .name")

                if [ -n "$PORT_NAME" ]; then
                    # PRIMARY found: Take the TEMPLATE, inject the primary port, save as REAL_SETTINGS
                    ${pkgs.jq}/bin/jq ".barConfigs[0].screenPreferences = [{\"name\": \"$PORT_NAME\", \"model\": \"$TARGET_MODEL\"}] | .barConfigs[0].showOnLastDisplay = false" "$TEMPLATE" > "$REAL_SETTINGS"
                else
                    # 2. PRIMARY missing: Ask Hyprland for the DEFAULT monitor's port
                    DEFAULT_PORT=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r ".[] | select(.model == \"$DEFAULT_MODEL\") | .name")
                    
                    if [ -n "$DEFAULT_PORT" ]; then
                        # DEFAULT found: Take the TEMPLATE, inject the default port, save as REAL_SETTINGS
                        ${pkgs.jq}/bin/jq ".barConfigs[0].screenPreferences = [{\"name\": \"$DEFAULT_PORT\", \"model\": \"$DEFAULT_MODEL\"}] | .barConfigs[0].showOnLastDisplay = false" "$TEMPLATE" > "$REAL_SETTINGS"
                    else
                        # 3. ULTIMATE FALLBACK: Clear preferences and fallback to last display
                        ${pkgs.jq}/bin/jq ".barConfigs[0].screenPreferences = [] | .barConfigs[0].showOnLastDisplay = true" "$TEMPLATE" > "$REAL_SETTINGS"
                    fi
                fi
            ''}";
        };
    };
}
