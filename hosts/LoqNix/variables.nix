{ choosenHost }:

let
    #                       0                      1                          2
    kernelList =  [ "linuxPackages_zen" "linuxPackages_xanmod" "linuxPackages_xanmod_latest" ];
    #                   0         1    2
    desktopList = [ "hyprland" "gnome" "" ];
    #                0       1      2
    videoList = [ "nvidia" "amd" "intel" ];
    #                        0 1 2
    bootloaderTimeoutList = [0 5 10];
    #                                                                                                       11
    windowsBootEntryList = [ "0000" "0001" "0002" "0003" "0004" "0005" "0006" "0007" "0008" "0009" "0010" "None"];

    kernel = builtins.elemAt kernelList 0;
    desktop = builtins.elemAt desktopList 0;
    video = builtins.elemAt videoList 0;

    bootloaderTimeout = builtins.elemAt bootloaderTimeoutList 0;

    #efibootmgr to discover
    windowsBootEntry = builtins.elemAt windowsBootEntryList 4;
in

{
    host = builtins.trace "Host = ${choosenHost}" choosenHost;
    kernel = builtins.trace "Kernel = ${kernel}" kernel;
    desktop = builtins.trace "Desktop = ${desktop}" desktop;
    video = builtins.trace "Video = ${video}" video;
    bootloaderTimeout = builtins.trace "BLT = ${toString bootloaderTimeout}" bootloaderTimeout;
    windowsBootEntry = builtins.trace "WindowsBootEntry = ${windowsBootEntry}" windowsBootEntry;

    laptop = true;

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

