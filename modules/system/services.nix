__:

{
    services = {
        # Firmware updates
        fwupd.enable = true;

        # Ssd trimming
        fstrim.enable = true;

        # Low Memory Killer
        earlyoom = {
            enable = true;
            enableNotifications = true;
            freeMemThreshold = 5;
            extraArgs = [
                "-g" 
                "--avoid"
                "^(steam|gamescope|java|minecraft|nvim|neovim)$"
            ];
        };

        openssh = {
            enable = true;
            openFirewall = true;
            startWhenNeeded = true;
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
                AllowUsers = [ "jl" ];
                MaxAuthTries = 3;
            };
        };

        tailscale = {
            enable = true;
        };

        sunshine = {
            enable = true;
            autoStart = false;
            capSysAdmin = true;
            openFirewall = true;
        };

        # Printing (Disabled for now)
        printing.enable = false;

        #sched_ext maybe i will try this again someday
    };
}

