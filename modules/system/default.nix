{ ... }:

{
    imports = [

        ./home.nix
        ./flatpak.nix
        ./secureboot.nix
        ./fonts.nix
        ./inputmethod.nix
        ./services.nix
        ./firewall.nix
        ./garbage-collection.nix
        ./core.nix
        ./systempkgs.nix
        ./vm.nix

        ./nvidia.nix#Waiting for the day i can comment this out
    ];
}

