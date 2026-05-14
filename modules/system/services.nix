{ pkgs, ... }:

{
    # Firmware updates
    services.fwupd.enable = true;

    # Ssd trimming
    services.fstrim.enable = true;

    # Low Memory Killer
    services.earlyoom = {
        enable = true;
        enableNotifications = true;
        freeMemThreshold = 5;
        extraArgs = [
            "-g" 
            "--avoid"
            "^(steam|gamescope|java|minecraft|nvim|neovim)$"
        ];
    };

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-uwsm.desktop'";
                user = "greeter";
            };
        };
    };

    # Printing (Disabled for now)
    services.printing.enable = false;

    #sched_ext maybe i will try this again someday
}

