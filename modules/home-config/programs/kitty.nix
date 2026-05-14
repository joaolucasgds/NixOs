{ ... }:

{
    programs.kitty = {
        enable = true;
        
        settings = {
            # Window Settings
            background_opacity = "0.1";
            background_blur = "1";
            hide_window_decorations = "yes";
            
            # Dimensions (Kitty requires 'c' to denote cells/columns instead of pixels)
            remember_window_size = "no";
            initial_window_width = "105c";
            initial_window_height = "32c";

            # Font Settings
            # Kitty automatically detects bold/italic variants if the family name is correct
            font_family = "FiraCode Nerd Font";
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";
            font_size = "13.0";

            # Cursor & Mouse
            cursor_shape = "beam";
            copy_on_select = "yes";
            # A negative value tells Kitty to hide the mouse immediately when typing
            mouse_hide_wait = "-1.0"; 
        };

        # Kitty does not have a native "live_config_reload" boolean, 
        # but it natively reloads when it receives a SIGUSR1 signal.
        # Imports are handled via string inclusion in extraConfig.
        extraConfig = ''
            include dank-tabs.conf
            include dank-theme.conf
        '';
    };
}

