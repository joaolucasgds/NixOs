{ pkgs, ... }:

{
    #Packages for hyprland rice
    environment.systemPackages = [
        pkgs.polkit_gnome
    ];

    programs.kdeconnect.enable = true;
    programs.mpv = {
        enable = true;
    };
}
