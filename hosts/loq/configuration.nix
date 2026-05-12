{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/system

        #hyprland 
        ../../modules/hyprland/hyprland.nix
        ../../modules/hyprland/pkgs.nix
    ];

    # Host indentity
    networking.hostName = "NixOs"; 
    networking.networkmanager.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.loader.efi.canTouchEfiVariables = true;

    #i2c needed for ddcutil
    hardware.i2c.enable = true;

    system.stateVersion = "26.05";
}
