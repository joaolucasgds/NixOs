{ ... }:

{
  systemd.user.services."gpu-screen-recorder-ui" = {
    Unit = {
      Description = "GPU Screen Recorder UI Service";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Environment = "PATH=/run/current-system/sw/bin:/home/jl/.nix-profile/bin:/usr/bin:/bin";
      ExecStart = "/run/current-system/sw/bin/flatpak run com.dec05eba.gpu_screen_recorder gsr-ui";
      KillSignal = "SIGINT";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
