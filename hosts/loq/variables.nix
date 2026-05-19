let
    desktopList = [ "hyprland" "gnome"];
    videoList = [ "nvidia" "amd" "intel" ];
in

{
    host = "LoqNix";
    desktop = builtins.elemAt desktopList 0;
    video = builtins.elemAt videoList 0;

    # Monitor setup Details | hw-info to find data
    primaryMonitorModel = "AOC 24G4";
    defaultMonitorModel = "Chimei Innolux Corporation 0x1552";
}

