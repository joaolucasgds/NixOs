{ pkgs, ... }:

{
    xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = false;

        desktop = null;
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ 
            pkgs.xdg-desktop-portal-hyprland
            pkgs.xdg-desktop-portal-gtk 
        ];
        config.common.default = [ "hyprland" "gtk" ]; #
    };
}

