{ ... }:

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

    # Printing (Disabled for now)
    services.printing.enable = false;
}

