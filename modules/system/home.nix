{ inputs, ... }:

{
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.jl.isNormalUser = true;

    home-manager = {

        extraSpecialArgs = { inherit inputs; };

        users.jl = { pkgs, ... }: {

            imports = [ ../home-config ];

            home.stateVersion = "25.11";

        };
    };
}
