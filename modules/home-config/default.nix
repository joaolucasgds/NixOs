{ ... }:

{
    imports = [
        #Core
        ./dconf.nix
        ./xdg.nix
        ./wallpapers.nix

        #User systemd services
        ./services/gpu-screen-recorder.nix

        #Programs
        ./programs/alacritty.nix
        ./programs/bash.nix
        ./programs/fastfetch.nix
        ./programs/git.nix
        ./programs/lazygit.nix
        ./programs/nvim.nix
        ./programs/vesktop.nix
        ./programs/bruh.nix
    ];
}

