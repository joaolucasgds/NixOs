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
        lockAtStartup = true;
        lockScreenShowProfileImage = false;

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
                TARGET_PORT="${hostvars.prMonitor}"
                DEFAULT_PORT="${hostvars.seMonitor}"
                
                TEMPLATE="$HOME/.config/DankMaterialShell/settings-template.json"
                REAL_SETTINGS="$HOME/.config/DankMaterialShell/settings.json"

                # Fetch the JSON snippet for the monitors if they exist
                PR_JSON=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$TARGET_PORT\")")
                SE_JSON=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$DEFAULT_PORT\")")

                if [ -n "$PR_JSON" ]; then
                    # PRIMARY found: Extract the real description string for DMS
                    REAL_MODEL=$(echo "$PR_JSON" | ${pkgs.jq}/bin/jq -r ".description")
                    ${pkgs.jq}/bin/jq ".barConfigs[0].screenPreferences = [{\"name\": \"$TARGET_PORT\", \"model\": \"$REAL_MODEL\"}] | .barConfigs[0].showOnLastDisplay = false" "$TEMPLATE" > "$REAL_SETTINGS"
                elif [ -n "$SE_JSON" ]; then
                    # DEFAULT found: Extract the real description string for DMS
                    REAL_MODEL=$(echo "$SE_JSON" | ${pkgs.jq}/bin/jq -r ".description")
                    ${pkgs.jq}/bin/jq ".barConfigs[0].screenPreferences = [{\"name\": \"$DEFAULT_PORT\", \"model\": \"$REAL_MODEL\"}] | .barConfigs[0].showOnLastDisplay = false" "$TEMPLATE" > "$REAL_SETTINGS"
                else
                    # 3. ULTIMATE FALLBACK: Clear preferences and fallback to last display
                    ${pkgs.jq}/bin/jq ".barConfigs[0].screenPreferences = [] | .barConfigs[0].showOnLastDisplay = true" "$TEMPLATE" > "$REAL_SETTINGS"
                fi
            ''}";
        };
    };
}
