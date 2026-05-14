{ pkgs, ... }:

{
    #Packages for hyprland rice
    environment.systemPackages = [
        pkgs.polkit
    ];
}
