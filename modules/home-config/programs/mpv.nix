{ ... }:

{
    programs.mpv = {
        enable = true;
        #Make sure images are zoomable
        extraInput = ''
            Ctrl+WHEEL_UP add video-zoom 0.1
            Ctrl+WHEEL_DOWN add video-zoom -0.1
        '';
    };
}
