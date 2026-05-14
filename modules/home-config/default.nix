{ ... }:

{
    imports = [
        #Core
        ./dconf.nix
        ./xdg.nix
        ./wallpapers.nix

        #User systemd services
        ./services/cleanhome.nix
        ./services/gpu-screen-recorder.nix
        ./services/kdeconnect.nix
        ./services/vesktop.nix

        #Programs
        ./programs/alacritty.nix
        ./programs/bash.nix
        ./programs/fastfetch.nix
        ./programs/git.nix
        ./programs/lazygit.nix
        ./programs/nvim.nix
        ./programs/vesktop.nix
        ./programs/bruh.nix
        ./programs/zen-browser.nix

        #hyprland
        ./hyprland.nix

        #dms
        ./DankMaterialShell.nix
        ./services/dmsSettings.nix

        #input
        ./fcitx5.nix
        
        #theming
        ./theming.nix

    ];
}

