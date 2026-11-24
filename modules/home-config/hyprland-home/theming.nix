{ pkgs, config,... }:

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
        pkgs.adwaita-icon-theme
    ];

    #Putting this here so i never have to press the "Apply GTK colors" button on new installs
    xdg.configFile."gtk-4.0/gtk.css".text = ''
        @import url("dank-colors.css");
    '';
}
