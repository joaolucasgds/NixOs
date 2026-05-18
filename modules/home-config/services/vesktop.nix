{ pkgs, config, ... }:

{
    systemd.user.services."vesktop" = {
        Unit = {
            Description = "Vesktop Discord Client (Minimized)";
            After = [ "graphical-session.target" ];
        };

        Service = {
            # Keeping your existing PATH environment
            Environment = "PATH=/run/current-system/sw/bin:${config.home.homeDirectory}/.nix-profile/bin:/usr/bin:/bin";
            
            # Grabs the exact Nix store path for Vesktop and appends the flag
            ExecStart = "${pkgs.vesktop}/bin/vesktop --start-minimized";
            
            KillSignal = "SIGINT";
            Restart = "on-failure";
            RestartSec = "5s";
        };

        Install = {
            WantedBy = [ "graphical-session.target" ];
        };
    };
}
