{ inputs, pkgs, ...}: 

{
    imports = [
        inputs.dms.homeModules.dank-material-shell
    ];

    programs.dank-material-shell = {
        enable = true;

        systemd = {
            enable = true;
            restartIfChanged = true;
        };

        managePluginSettings = true;
        plugins = {

            dankKDEConnect = {
                enable = true;
                src = "${pkgs.fetchFromGitHub {
                    owner = "AvengeMedia";
                    repo = "dms-plugins";
                    rev = "master"; 
                    hash = "sha256-QgeeB6Ix8L5oaqTUCopPvGu6vr0ECsF+jO3mQIxPKIw="; 
                }}/DankKDEConnect";
            };

            wallpaperCarousel = {
                enable = true;
                src = "${pkgs.fetchFromGitHub {
                    owner = "motor-dev";
                    repo = "wallpaperCarousel";
                    rev = "main"; 
                    hash = "sha256-j0YnjGddXKozLWk9jUkvO+f7wUkRFXcIT5FfurrJsTo="; 
                }}";

                settings = {
                    wallpaperDirectory = "/home/jl/Pictures/Wallpapers";
                };
            };
        };

        enableSystemMonitoring = true;     # System monitoring widgets (dgop)
        enableVPN = true;                  # VPN management widget
        enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
        enableAudioWavelength = true;      # Audio visualizer (cava)
        enableCalendarEvents = true;       # Calendar integration (khal)
    };
}

