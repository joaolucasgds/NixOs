{ pkgs, ... }:

{
    programs.alacritty = {
        enable = true;
        settings = {
            window = {
                opacity = 0.1;
                blur = true;
                decorations = "None";
                padding = {
                    x = 8;
                    y = 8;
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

            colors = {
                primary = {
                    background = "#000000";
                    foreground = "#f0f0f0";
                };

                cursor = {
                    text = "#000000";
                    cursor = "#ffffff";
                };

                normal = {
                    black = "#1c1c1c";
                    red = "#ff5f5f";
                    green = "#5fff87";
                    yellow = "#ffd75f";
                    blue = "#5fafff";
                    magenta = "#ff5fff";
                    cyan = "#5fffff";
                    white = "#e4e4e4";
                };

                bright = {
                    black = "#3a3a3a";
                    red = "#ff8787";
                    green = "#87ffaf";
                    yellow = "#ffdf87";
                    blue = "#87caff";
                    magenta = "#ff87ff";
                    cyan = "#87ffff";
                    white = "#ffffff";
                };
            };

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
}
