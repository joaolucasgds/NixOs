{ pkgs, ... }:

{
    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                padding = {
                    top = 2;
                    left = 1;
                    right = 2;
                };
                color = {
                    "1" = "white";
                    "2" = "white";
                    "3" = "white";
                    "4" = "white";
                    "5" = "white";
                    "6" = "white";
                    "7" = "white";
                    "8" = "white";
                    "9" = "white";
                };
            };
            display = {
                color = "black";
            };
            modules = [
                {
                    type = "title";
                    color = {
                        user = "black";
                        at = "black";
                        host = "white";
                    };
                }
                "separator"
                "os"
                "host"
                "kernel"
                "uptime"
                "packages"
                "shell"
                "display"
                "de"
                "wm"
                "wmtheme"
                "theme"
                "icons"
                "font"
                "cursor"
                "terminal"
                "terminalfont"
                "cpu"
                "gpu"
                "memory"
                "swap"
                "disk"
                "localip"
                "battery"
                "poweradapter"
                "locale"
                "break"
                "colors"
            ];
        };
    };
}
