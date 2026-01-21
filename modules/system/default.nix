{ ... }:

{
    imports = [
        ./de.nix
        ./flatpak.nix
        ./home.nix
        ./secureboot.nix
        ./earlyoom.nix
        ./fonts.nix
        ./inputmethod.nix
        ./services.nix
        ./firewall.nix
        ./garbage-collection.nix
        ./systempkgs.nix

        ./nvidia.nix
    ];
}

