{ pkgs, ... }:

{
    programs.vesktop = {
	    enable = true;
    };

    xdg.configFile."autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=Vesktop
        Comment=Vesktop autostart script
        Exec=${pkgs.vesktop}/bin/vesktop --start-minimized
        StartupNotify=false
        Terminal=false
        Icon=vesktop
    '';
}

