{ ... }: 

{
    imports = [
        ./hyprland-home/hyprland.nix
        ./hyprland-home/hyprportal.nix
        ./hyprland-home/DankMaterialShell.nix
        ./hyprland-home/theming.nix

        ./services/kdeconnect.nix
        ./services/dmsSettings.nix
    ];
}
