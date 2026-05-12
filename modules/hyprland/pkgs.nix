{ pkgs, ... }:

{
    #Packages for hyprland rice
    environment.systemPackages = [
        pkgs.waybar
        pkgs.eww
    ];
}
