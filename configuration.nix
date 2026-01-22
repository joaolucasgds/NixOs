{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./modules/system
    ];

    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;

    networking.hostName = "NixOs"; 

    networking.networkmanager.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = false;

    #Needed for ddcutil
    hardware.i2c.enable = true;

    users.users.root = {
        initialPassword = "123"; #Set up actual passwords on install
    };

    security.sudo.extraConfig = ''
        Defaults rootpw
    '';

    system.stateVersion = "26.05"; # Did you read the comment?
    documentation.nixos.enable = false;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
