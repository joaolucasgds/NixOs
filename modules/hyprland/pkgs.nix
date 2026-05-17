{ pkgs, ... }:

{
    #Packages for hyprland rice
    environment.systemPackages = [
        pkgs.polkit_gnome
        pkgs.wl-kbptr
        pkgs.wlrctl
        pkgs.playerctl
    ];

    programs.kdeconnect.enable = true;
}
