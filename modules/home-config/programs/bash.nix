{ ... }:

{
    programs.bash = {
	    enable = true;
	    initExtra = ''
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
                ssh-add -l >/dev/null 2>&1 || eval "$(keychain --eval --quiet ~/.ssh/id_ed25519)"
                command lazygit "$@"
            }
        '';
        bashrcExtra = ''
            export PS1="\[\033[38;5;4m\]\u@\h \w \$ \[\033[0m\]"
        '';
    };
}
