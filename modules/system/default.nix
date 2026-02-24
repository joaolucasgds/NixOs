{ ... }:

{
    imports = [
        ./de.nix
        ./flatpak.nix
        ./home.nix
        ./secureboot.nix
        ./fonts.nix
        ./inputmethod.nix
        ./services.nix
        ./firewall.nix
        ./garbage-collection.nix
        ./core.nix
        ./systempkgs.nix
        ./vm.nix

        ./nvidia.nix
    ];
}

