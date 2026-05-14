{ pkgs, ... }:

{
    #Packages for hyprland rice
    environment.systemPackages = [
        pkgs.polkit_gnome
    ];

    programs.kdeconnect.enable = true;
    programs.mpv = {
        enable = true;
        #Make sure images are zoomable
        extraInput = ''
            Ctrl+WHEEL_UP add video-zoom 0.1
            Ctrl+WHEEL_DOWN add video-zoom -0.1
        '';
    };
}
