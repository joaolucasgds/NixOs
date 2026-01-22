{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./modules/system
    ];

    # Host indentity
    networking.hostName = "NixOs"; 
    networking.networkmanager.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.loader.efi.canTouchEfiVariables = true;

    #i2c needed for ddcutil, cups disabled
    hardware.i2c.enable = true;
    services.printing.enable = false;

    security.sudo.extraConfig = ''
        Defaults rootpw
    '';

    system.stateVersion = "26.05";
}
