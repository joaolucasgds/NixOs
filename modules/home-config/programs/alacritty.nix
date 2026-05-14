{ config, lib, ... }:

{
    programs.alacritty = {
        enable = true;
        settings = {
            window = {
                opacity = 0.1;
                blur = true;
                decorations = "None";
                dimensions = {
                    columns = 105;
                    lines = 32;
                };
            };

            font = {
                size = 13.0;

                normal = {
                    family = "FiraCode Nerd Font";
                    style = "Regular";
                };

                bold = {
                    family = "FiraCode Nerd Font";
                    style = "bold";
                };

                italic = {
                    family = "FiraCode Nerd Font";
                    style = "italic";
                };
            };

            general.live_config_reload = true;
            general.import = [
                "~/.config/alacritty/dank-theme.toml"
            ];

            cursor = {
                style = "Beam";
            };

            selection = {
                save_to_clipboard = true;
            };

            mouse = {
                hide_when_typing = true;
            };
        };
    };

    home.activation = {
        ensureDmsAlacrittyTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            # Define the path
            THEME_PATH="${config.home.homeDirectory}/.config/alacritty/dank-theme.toml"

            # Create the directory if it's missing
            mkdir -p "$(dirname "$THEME_PATH")"

            # If the file doesn't exist, create a dummy one
            # This prevents Alacritty from crashing on first boot
            if [ ! -f "$THEME_PATH" ]; then
            echo "[colors]" > "$THEME_PATH"
            fi
        '';
    };
}

