{ pkgs, ... }:

{
    #Packages for hyprland rice
    environment.systemPackages = [
        pkgs.polkit_gnome
        pkgs.wl-kbptr
        pkgs.ydotool
    ];

    programs.kdeconnect.enable = true;
}
