{ ... }:

{
    programs.bash = {
	    enable = true;
	    initExtra = ''
            # Auto-start tmux unless we are already inside it or in a Nix shell
            if [[ -z "$TMUX" && -z "$IN_NIX_SHELL" && $- == *i* ]]; then
                exec tmux new-session -A -s default
            fi

            fastfetch

            function y() {
                local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
                yazi "$@" --cwd-file="$tmp"
                if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                    builtin cd -- "$cwd"
                fi
                rm -f -- "$tmp"
            }
            
            lazygit() {
                ssh-add -l >/dev/null 2>&1 || eval "$(keychain --eval --quiet ~/.ssh/github-signing)"
                command lazygit "$@"
            }
        '';
        bashrcExtra = ''
            export PS1="\[\033[38;5;4m\]\u@\h \w \$ \[\033[0m\]"
        '';
    };
}
