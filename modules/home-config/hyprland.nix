{ ... }:

let
    masterWallpaperDir = "/home/jl/Pictures/Wallpapers";
    defaultWallpaper = "${masterWallpaperDir}/makima.png";
in

{
    wayland.windowManager.hyprland = {
        enable = true;
        package = null; # installed as a systempkg, null here to prevent duplicate

        settings = {
            monitor = ", highrr, auto, 1";

            "$terminal" = "alacritty";
            "$mainMod" = "SUPER";

            bind = [
                #Keybinds for apps

                "$mainMod, Q, killactive"
                "$mainMod, Q, exec, dms ipc call bar reveal index 0" #also revel bar
                "$mainMod, T, exec, $terminal"
                "$mainMod, N, exec, zen-beta"
                "$mainMod SHIFT, minus, exec, bruh - 10"
                "$mainMod SHIFT, equal, exec, bruh + 10"
                "$mainMod, D, exec, vesktop"
                "$mainMod, F, exec, nautilus"
                "$mainMod, P, exec, proton-pass"
                "$mainMod, J, exec, protonvpn-app"
                "$mainMod, A, exec, dms ipc call spotlight toggle"
                "$mainMod, S, exec, dms ipc call settings toggle"
                "$mainMod, Z, exec, dms ipc call bar toggle index 0"
                "$mainMod, W, exec, dms ipc wallpaperCarousel toggle"
                
                # --- Window Management ---
            
                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"

                # Move active window with mainMod + SHIFT + arrow keys
                "$mainMod SHIFT, left, movewindow, l"
                "$mainMod SHIFT, right, movewindow, r"
                "$mainMod SHIFT, up, movewindow, u"
                "$mainMod SHIFT, down, movewindow, d"

                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_up, workspace, e+1"
                "$mainMod, mouse_down, workspace, e-1"
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
                # Wait 3 seconds for the DMS IPC socket to initialize, then check/set the wallpaper.
                # Added 2>/dev/null because on a TRUE first boot, session.json won't even exist yet.
                "sh -c 'sleep 3 && if ! grep -q \"wallpaperPath\" ~/.local/state/DankMaterialShell/session.json 2>/dev/null; then dms ipc wallpaper set ${defaultWallpaper}; fi'"
            ];
        };
    };
}
