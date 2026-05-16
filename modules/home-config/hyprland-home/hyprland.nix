{ pkgs, hostvars, ... }:

let
    masterWallpaperDir = "/home/jl/Pictures/Wallpapers";
    defaultWallpaper = "${masterWallpaperDir}/makima.png";
in

{
    wayland.windowManager.hyprland = {
        enable = true;
        package = null; # installed as a systempkg, null here to prevent duplicate
        configType = "hyprlang";

        settings = {
            monitor = ", highrr, auto, 1";

            workspace = [
                "1, monitor:desc:${hostvars.primaryMonitorModel}, default:true"
                "5, monitor:desc:${hostvars.defaultMonitorModel}, default:true"
            ];

            "$terminal" = "kitty";
            "$mainMod" = "SUPER";

            bind = [
                # Shutdown
                "$mainMod, Pause, exec, shutdown now"

                #Keybinds for apps

                "$mainMod CONTROL, TAB, killactive"
                "$mainMod CONTROL, TAB, exec, dms ipc call bar reveal index 0" #also revel bar
                "CONTROL ALT, Caps_Lock, exec, $terminal"
                "CONTROL ALT, S, exec, zen-beta"
                "CONTROL ALT, D, exec, vesktop"
                "CONTROL ALT, P, exec, proton-pass"
                "CONTROL ALT, J, exec, protonvpn-app"
                "CONTROL ALT, A, exec, dms ipc call spotlight toggle"
                "CONTROL ALT, TAB, exec, dms ipc call settings toggle"
                "$mainMod CONTROL SHIFT, Z, exec, dms ipc call bar toggle index 0"
                "CONTROL ALT, W, exec, dms ipc wallpaperCarousel toggle"
                "$mainMod CONTROL, minus, exec, bruh - 10"
                "$mainMod CONTROL, equal, exec, bruh + 10"
                "$mainMod SHIFT, S, exec, hyprshot --m region"
                
                # --- Window Management ---
            
                # Move focus with mainMod + arrow keys
                "$mainMod, H, movefocus, l"
                "$mainMod, L, movefocus, r"
                "$mainMod, K, movefocus, u"
                "$mainMod, J, movefocus, d"

                # Move active window with mainMod + CONTROL + hjkl
                "$mainMod CONTROL, H, movewindow, l"
                "$mainMod CONTROL, L, movewindow, r"
                "$mainMod CONTROL, K, movewindow, u"
                "$mainMod CONTROL, J, movewindow, d"

                # Switch workspaces with mainMod + CONTROL + key - 1to5
                "$mainMod CONTROL, Shift_L, workspace, 1"
                "$mainMod CONTROL, backslash, workspace, 2"
                "$mainMod CONTROL, Z, workspace, 3"
                "$mainMod CONTROL, X, workspace, 4"
                "$mainMod CONTROL, ., workspace, 5"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "CONTROL ALT, Shift_L, movetoworkspace, 1"
                "CONTROL ALT, backslash, movetoworkspace, 2"
                "CONTROL ALT, Z, movetoworkspace, 3"
                "CONTROL ALT, X, movetoworkspace, 4"
                "CONTROL ALT, ., movetoworkspace, 5"

                # # <wl-kbptr>
                # "$mainMod, H, exec, 0"
                # "$mainMod, J, exec, 0"
                # "$mainMod, K, exec, 0"
                # "$mainMod, L, exec, 0"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_up, workspace, e+1"
                "$mainMod, mouse_down, workspace, e-1"
            ];

            bindel = [
                ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ];

            bindl = [
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPrev, exec, playerctl previous"
            ];

            input = {
                kb_layout = "br";
                accel_profile = "flat";
            };

            env = [
                # Desktop Environment & Wayland basics
                "XDG_CURRENT_DESKTOP,Hyprland"
                "XDG_SESSION_TYPE,wayland"
                "XDG_SESSION_DESKTOP,Hyprland"

                # Input Methods (Japanese/Mandarin)
                "XMODIFIERS,@im=fcitx"
                "QT_IM_MODULE,fcitx"
                "SDL_IM_MODULE,fcitx"
            ];

            #Mouse and monitor import so DMDankMaterialShellS changes persist 
            source = [
                "/home/jl/.config/hypr/dms/cursor.conf"
                "/home/jl/.config/hypr/dms/outputs.conf"
            ];

            animations = {
                enabled = true;
                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                animation = [
                    "windows, 1, 3, myBezier"
                    "windowsOut, 1, 3, default, popin 80%"
                    "border, 1, 5, default"
                    "fade, 1, 3, default"
                    "workspaces, 1, 1, default"
                ];
            };

            exec-once = [

                "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" #Gemini told me this would make DMS start faster
                "fcitx5 -d -r"
                "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
                # Wait 3 seconds for the DMS IPC socket to initialize, then check/set the wallpaper.
                # Added 2>/dev/null because on a TRUE first boot, session.json won't even exist yet.
                "sh -c 'sleep 3 && if ! grep -q \"wallpaperPath\" ~/.local/state/DankMaterialShell/session.json 2>/dev/null; then dms ipc wallpaper set ${defaultWallpaper}; fi'"
            ];
        };
    };
}
