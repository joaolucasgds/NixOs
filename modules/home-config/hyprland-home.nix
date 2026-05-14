{ ... }: 

{
    imports = [
        ./hyprland.nix
        ./DankMaterialShell.nix
        ./theming.nix

        ./services/kdeconnect.nix
        ./services/dmsSettings.nix
    ];
}
