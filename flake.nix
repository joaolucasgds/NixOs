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
            url = "https://github.com/joaolucasgds/Wallpapers/releases/download/Wallpapers/wallpapers.tar.gz";
            flake = false;
        };

        lanzaboote = { 
            url = "github:nix-community/lanzaboote/v1.0.0";#Don't forget to change this version from time to time
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

        dms = {
            url = "github:AvengeMedia/DankMaterialShell/stable";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, ... }@inputs: 
        let
            hostNameList = [ "LoqNix" ];

            choosenHost = builtins.elemAt hostNameList 0;
        in
    {
        nixosConfigurations = {
            "${choosenHost}" = nixpkgs.lib.nixosSystem{
                system = "x86_64-linux";
                specialArgs = { 
                    inherit inputs;
                    hostvars = import ./hosts/${choosenHost}/variables.nix { inherit choosenHost; };
                };
                modules = [
                    ./hosts/${choosenHost}/configuration.nix
                ];
            };
        };
    };
}
