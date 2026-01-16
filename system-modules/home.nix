{ inputs, ... }:

{
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.jl.isNormalUser = true;

    home-manager.users.jl = { pkgs, ... }: {

        extraSpecialArgs = { inherit inputs; };

        imports = [ ../home-config ];

        nixpkgs.config.allowUnfree = true;
        home.stateVersion = "25.11";

    };
}
