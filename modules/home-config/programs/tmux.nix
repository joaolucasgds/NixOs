__:

{
    programs.tmux = {
        enable = true;
        mouse = true;
        keyMode = "vi";

        extraConfig = ''
            # --- 1. Open new windows and panes in the current directory ---
            bind c new-window -c "#{pane_current_path}"
            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"

            set-option -g status-style bg=white,fg=black

            # Hide the status bar by default
            set -g status off
            # Toggle status bar visibility with Prefix + b
            bind-key b set-option -g status
        '';
    };
}

