{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-contacts
    gnome-weather
    gnome-maps
    simple-scan
    gnome-tour
    yelp
    xterm
    gnome-connections
    gnome-software
  ]);

  
}
