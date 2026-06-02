{ inputs, hostvars, ... }:

{
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.jl = {
        isNormalUser = true;
        description = "João Lucas";
        extraGroups = [ "networkmanager" "wheel" "i2c" "libvirtd" ];
        initialPassword = "123";

        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqoNTqA4isNTTC5kLUfMajYyRbICwPX3S3foe55ifNT jl@loqnix"
        ];
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = { inherit inputs hostvars; };

        users.jl = { pkgs, ... }: {

            imports = [ ../home-config ];

            home.stateVersion = "25.11";

        };
    };
}
