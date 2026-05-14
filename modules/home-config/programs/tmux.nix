{ ... }:

{
    programs.tmux = {
        enable = true;
        mouse = true;

        extraConfig = ''
            set-option -g status-style bg=white,fg=black

            # Toggle status bar visibility with Prefix + b
            bind-key b set-option -g status
        '';
    };
}

