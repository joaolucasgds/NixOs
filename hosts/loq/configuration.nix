{ pkgs, hostvars, lib, ... }:

let
    hardwareModule = [ ./hardware-configuration.nix ];
    systemModule = [ ../../modules/system ];
    deModule = lib.optionals (hostvars.desktop == "hyprland") [
        ../../modules/hyprland
    ] ++ lib.optionals (hostvars.desktop == "gnome") [
        ../../modules/gnome
    ];
in

{
    imports = hardwareModule ++ systemModule ++ deModule;

    # Host indentity
    networking.hostName = "NixOs"; 
    networking.networkmanager.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.loader.efi.canTouchEfiVariables = true;

    #i2c needed for ddcutil
    hardware.i2c.enable = true;

    system.stateVersion = "26.05";
}
