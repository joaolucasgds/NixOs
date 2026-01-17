{ inputs, ... }:

{
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.jl.isNormalUser = true;

    home-manager = {

        extraSpecialArgs = { inherit inputs; };

        users.jl = { pkgs, ... }: {

            imports = [ ../home-config ];

            nixpkgs.config.allowUnfree = true;
            home.stateVersion = "25.11";

        };
    };
}
