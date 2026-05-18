{ hostvars, ... }:

{
    programs.bash = {
	    enable = true;
	    initExtra = ''
            # Auto-start tmux unless we are already inside it or in a Nix shell
            if [[ -z "$TMUX" && -z "$IN_NIX_SHELL" && $- == *i* ]]; then
                exec tmux new-session -A -s default
            fi

            fastfetch

            la() {
                ssh-add -l >/dev/null 2>&1 || eval "$(keychain --eval --quiet ~/.ssh/github-signing)"
                command lazygit "$@"
            }

            n() {
                command nvim "$@"
            }
            
            rebuild() {
                sudo nixos-rebuild switch --flake ~/nixos/#${hostvars.host}
            }

            uefi() {
                systemctl reboot --firmware-setup
            }
        '';
        bashrcExtra = ''
            export PS1="\[\033[38;5;4m\]\u@\h \w \$ \[\033[0m\]"
        '';
    };
}
