{ hostvars, config, lib, ... }:

{
    programs.bash = {
	    enable = true;
	    initExtra = ''
            # Auto-start tmux unless we are already inside it or in a Nix shell
            if [[ -z "$TMUX" && -z "$IN_NIX_SHELL" && $- == *i* ]]; then
                exec tmux new-session -A -s default
            fi

            fastfetch

            3() {
                ssh-add -l >/dev/null 2>&1 || eval "$(keychain --eval --quiet ~/.ssh/github-signing)"
                command lazygit "$@"
            }

            2(){
                y
            }

            1() {
                command nvim "$@"
            }
            
            rebuild() {
                sudo nixos-rebuild switch --flake ~/nixos/#${hostvars.host}
            }

            config(){
                cd ${config.home.homeDirectory}/nixos/
            }

            uefi() {
                systemctl reboot --firmware-setup
            }

            usb() {
                sudo mkdir -p /mnt/usb/
                sudo mount -o rw,uid=$(id -u),gid=$(id -g) "$1" /mnt/usb
                yazi /mnt/usb/
            }

            start_sunshine() {
                systemctl --user start sunshine
            } 

            stop_sunshine() {
                systemctl --user stop sunshine
            }

            status_sunshine() {
                systemctl --user status sunshine
            } 
        '' + lib.optionalString (hostvars.windowsBootEntry != "") '' 

            windows() {
                sudo efibootmgr -n ${hostvars.windowsBootEntry}
                sudo reboot
            }
        '';

        bashrcExtra = ''
            export PS1="\[\033[38;5;4m\]\u@\h \w \$ \[\033[0m\]"
        '';
    };
}
