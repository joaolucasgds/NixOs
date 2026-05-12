{ ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;

        settings = {
            monitor = ", highrr, auto, 1";

            "$terminal" = "alacritty";
            "$mainMod" = "SUPER";

            bind = [
                #Keybinds for apps

                "$mainMod, Q, killactive"
                "$mainMod, T, exec, $terminal"
                "$mainMod, N, exec, zen-beta"
                "$mainMod SHIFT, minus, exec, bruh - 10"
                "$mainMod SHIFT, equal, exec, bruh + 10"
                "$mainMod, D, exec, vesktop"
                "$mainMod, F, exec, nautilus"
                "$mainMod, P, exec, proton-pass"
                "$mainMod, J, exec, protonvpn-app"
                
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
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
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
                
                # Force Dark Mode & Wayland for Qt/GTK
                "QT_QPA_PLATFORM,wayland"
                "GTK_THEME,Adwaita-dark"

                # Input Methods (Japanese/Mandarin)
                "XMODIFIERS,@im=fcitx"
                "QT_IM_MODULE,fcitx"
                "SDL_IM_MODULE,fcitx"
            ];

            exec-once = [
                "fcitx5 -d -r"
            ];
        };
    };
}
