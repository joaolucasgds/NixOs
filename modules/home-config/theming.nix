{ pkgs, ... }:

{
    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
    };

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "adw-gtk3";
        };
    };

    home.packages = [
        pkgs.adw-gtk3 
    ];

}
