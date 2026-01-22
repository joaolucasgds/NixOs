{
    description = "The best flake that's ever lived";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = { 
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

        nvf = {
            url = "github:NotAShelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        wallpapers = {
            url = "git+https://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@github.com/JoaoLucasGdS/Wallpapers.git?ref=main";
            flake = false;
        };

        lanzaboote = { 
            url = "github:nix-community/lanzaboote/v1.0.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
                nixpkgs.follows = "nixpkgs";
                home-manager.follows = "home-manager";
            };
        };
    };

    outputs = { self, nixpkgs, ... }@inputs: {

        nixosConfigurations.NixOs = nixpkgs.lib.nixosSystem{
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
            ];
        };

    };
}
