{ ... }: 

{
    imports = [
        ./hyprland-home/hyprland.nix
        ./hyprland-home/hyprportal.nix
        ./hyprland-home/DankMaterialShell.nix
        ./hyprland-home/theming.nix

        ./programs/hyprshot.nix
        
        ./services/kdeconnect.nix
        ./services/dmsSettings.nix
    ];
}
