let
    desktopList = [ "hyprland" "gnome"];
    videoList = [ "nvidia" "amd" "intel" ];
in

{
    host = "LoqNix";
    desktop = builtins.elemAt desktopList 0;
    video = builtins.elemAt videoList 0;

    # Monitor setup Details | grep . /sys/class/drm/*/status
    prMonitor = "HDMI-A-1";
    seMonitor = "eDP-1";
    thMonitor = "";
    foMonitor = "";
    fiMonitor = ""; 
}

