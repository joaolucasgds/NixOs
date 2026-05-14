{ hostvars, lib, ... }:

let
    coreHome = [
        #Core
        ./default/xdg.nix
        ./default/wallpapers.nix
        ./default/fcitx5.nix
        #Programs
        # ./programs/alacritty.nix
        ./programs/kitty.nix

        ./programs/tmux.nix
        ./programs/bash.nix
        ./programs/git.nix
        ./programs/lazygit.nix
        ./programs/nvim.nix
        ./programs/vesktop.nix
        ./programs/bruh.nix
        ./programs/zen-browser.nix
        #Flatpak settings
        ./flatpak-settings/gpu-screen-recorder-ui-flatpak.nix
        #User systemd services
        ./services/cleanhome.nix
        ./services/gpu-screen-recorder.nix
        ./services/vesktop.nix
    ];

    hyprlandHome = lib.optionals (hostvars.desktop == "hyprland") [
        ./hyprland-home.nix
    ];

    gnomeHome = lib.optionals (hostvars.desktop == "gnome") [
        ./gnome-home.nix
    ];
in
{
    imports = coreHome ++ hyprlandHome ++ gnomeHome;
}

