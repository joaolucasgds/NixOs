{ pkgs, config, ... }:

{
    systemd.user.services."autostart-concord" = {
        Unit = {
            Description = "Auto start Concord TUI Discord client in tmux at login";
            After = [ "graphical-session.target" ];
        };

        Service = {
            Type = "oneshot";
            RemainAfterExit = true;
            Environment = "TMUX_TMPDIR=%t";

            ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.tmux}/bin/tmux has-session -t concord 2>/dev/null || ${pkgs.tmux}/bin/tmux new-session -d -s concord /etc/profiles/per-user/${config.home.username}/bin/concord'";
        };

        Install = {
            WantedBy = [ "graphical-session.target" ];
        };
    };
}
