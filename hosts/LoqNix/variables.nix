{ choosenHost }:

let
    kernelList =  [ "linuxPackages_zen" "linuxPackages_xanmod" "linuxPackages_xanmod_latest" ];
    desktopList = [ "hyprland" "gnome" "" ];
    videoList = [ "nvidia" "amd" "intel" ];
in

{
    host = choosenHost;

    kernel = builtins.elemAt kernelList 0;
    desktop = builtins.elemAt desktopList 0;
    video = builtins.elemAt videoList 0;

    #automatic github key would be better
    gitSigningPubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgZ1T0HJbldDUbQR1OwLym/46ECcYySP1VQslBTNjTt joaolucasgdesouza@gmail.com";

    # Monitor setup Details | grep . /sys/class/drm/*/status
    prMonitor = "HDMI-A-1";
    seMonitor = "eDP-1";
    thMonitor = "";
    foMonitor = "";
    fiMonitor = ""; 

    # Display minimun brightness value
    displayMBV= 0;
    laptopDisplayMBV = 50;

    #Would be cool if rebuild had a way to check for maintainerless pkgs
}

