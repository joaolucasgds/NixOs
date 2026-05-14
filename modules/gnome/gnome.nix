{ pkgs, ... }:

{
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

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

    environment.systemPackages = with pkgs.gnomeExtensions; [
        blur-my-shell caffeine clipboard-indicator gsconnect 
        coverflow-alt-tab reboottouefi dynamic-panel gamebar-overlay 
        hide-top-bar search-light brightness-control-using-ddcutil 
        do-not-disturb-while-screen-sharing-or-recording
        focus-follows-workspace
    ];

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ];

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "br";
        variant = "";
    };
}
