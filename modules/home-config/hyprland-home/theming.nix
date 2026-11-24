{ pkgs, config, ... }:

{
    qt = {
        enable = true;
        platformTheme.name = "qtct";
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

    #Putting this here so i never have to press the "Apply GTK colors" or "Apply QT colors" button on new installs
    xdg.configFile = {
        # Let GTK4 apps load the palette DMS generates for each wallpaper.
        "gtk-4.0/gtk.css".text = ''
            @import url("dank-colors.css");
        '';

        "gtk-3.0/gtk.css".text = ''
            @import url("dank-colors.css");
        '';

        # Use the native qt6ct palette for apps such as hyprland-share-picker.
        "qt6ct/qt6ct.conf".text = ''
            [Appearance]
            custom_palette=true
            color_scheme_path=${config.xdg.configHome}/qt6ct/colors/matugen.conf
        '';

        # Expose the live KDE palette under the filename KDE Connect reads.
        "dms-kde/kdeglobals".source =
            config.lib.file.mkOutOfStoreSymlink
                "${config.xdg.dataHome}/color-schemes/DankMatugen.colors";
    };

    xdg.systemDirs.config = [ "${config.xdg.configHome}/dms-kde" ];
}
