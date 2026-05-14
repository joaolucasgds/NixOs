{ inputs, hostvars, ... }:

{
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.jl = {
        isNormalUser = true;
        description = "João Lucas";
        extraGroups = [ "networkmanager" "wheel" "i2c" "libvirtd" ];
        initialPassword = "123";
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
