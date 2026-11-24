{ pkgs, config, hostvars, ... }:

let
        baseSettings = {
        configVersion = 42;

        # Wallpaper and theme
        wallpaperFillMode = "Fill";
        currentThemeName = "dynamic";
        matugenScheme = "scheme-vibrant";
        widgetColorMode = "colorful";
        fontFamily = "Inter Variable";

        # System and units
        windSpeedUnit = "ms";
        osdPosition = 4;
        clockFormat = "12h";
        lockAtStartup = false;
        acMonitorTimeout = 600;
        lockScreenShowProfileImage = false;

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
            dwl.cursorHideTimeout = 0;
        };

        # Transparent bar with opaque floating widget pills
        barElevationEnabled = false;
        barConfigs = [
            {
                id = "default";
                name = "Main Bar";
                enabled = true;
                visible = true;
                position = 0;

                followInterfaceStyle = false;
                transparency = 0;
                widgetFollowInterfaceStyle = false;
                widgetTransparency = 1;
                widgetStyle = "pills";

                surfaceColor = "default";
                surfaceCustomColor = "#6750A4";
                gothCornersEnabled = false;
                gothCornerRadiusOverride = false;
                squareCorners = false;
                attachToScreenEdge = false;
                noBackground = false;
                innerPadding = 2;
                borderEnabled = false;

                hoverPopouts = true;
                hoverPopoutDelay = "50";

                # dms-monitor-fix fills these in at startup.
                screenPreferences = [];
                showOnLastDisplay = false;

                leftWidgets = [
                    {
                        id = "launcherButton";
                        enabled = true;
                        launcherLogoMode = "os";
                        launcherLogoColorOverride = "primary";
                        launcherLogoSizeOffset = 8;
                    }
                    "workspaceSwitcher"
                    {
                        id = "focusedWindow";
                        enabled = true;
                        focusedWindowCompactMode = true;
                    }
                    { id = "dankKDEConnect"; enabled = true; }
                ];

                centerWidgets = [ "music" "clock" "weather" ];

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
    home.file.".config/dms/settings-template.json".text = builtins.toJSON baseSettings;

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
            ReadWritePaths = [ "%h/.config/dms" ];

            ExecStart = "${pkgs.writeShellScript "dms-inject" ''
                TARGET_PORT="${hostvars.prMonitor}"
                DEFAULT_PORT="${hostvars.seMonitor}"
                
                TEMPLATE="$HOME/.config/dms/settings-template.json"
                REAL_SETTINGS="$HOME/.config/dms/settings.json"

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
