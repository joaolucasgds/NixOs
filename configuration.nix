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

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?
    documentation.nixos.enable = false;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
