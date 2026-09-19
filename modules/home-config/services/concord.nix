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

            ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.tmux}/bin/tmux has-session -t default 2>/dev/null || (${pkgs.tmux}/bin/tmux new-session -d -s default -n concord /etc/profiles/per-user/${config.home.username}/bin/concord && ${pkgs.tmux}/bin/tmux new-window -t default:1)'";
        };

        Install = {
            WantedBy = [ "graphical-session.target" ];
        };
    };
}
