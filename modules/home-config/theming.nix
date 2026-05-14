{ pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            name = "adw-gtk3";
            package = pkgs.adw-gtk-theme;
        };

        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

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

    # 4. Environment Variables
    home.sessionVariables = {
        GTK_THEME = "adw-gtk3";
    };
}
