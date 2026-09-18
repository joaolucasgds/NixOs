{ ... }: 

{
    imports = [
        ./hyprland-home/hyprlandlua.nix
        ./hyprland-home/hyprportal.nix
        ./hyprland-home/DankMaterialShell.nix
        ./hyprland-home/theming.nix

        ./programs/yazi.nix
        ./programs/mpv.nix
        ./programs/keychain.nix
        
        ./services/kdeconnect.nix
        ./services/dmsSettings.nix
    ];
}
