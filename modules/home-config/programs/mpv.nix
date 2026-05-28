{ pkgs, ... }:

{
    programs.mpv = {
        enable = true;
        config = {
            image-display-duration = "inf"; # Keeps images open forever
            keep-open = "yes";              # Pauses videos on the last frame instead of closing
        };
        scripts = [pkgs.mpvScripts.mpris];
        #Make sure images are zoomable
        extraInput = ''
            Ctrl+WHEEL_UP add video-zoom 0.1
            Ctrl+WHEEL_DOWN add video-zoom -0.1
        '';
    };
}
