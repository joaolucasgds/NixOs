{ pkgs, ... }:

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
    gnome-connections
    gnome-software
    epiphany
    geary
    gnome-calendar
    gnome-music
    seahorse
    gnome-console
  ]);
}
