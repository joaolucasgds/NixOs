{ lib, hostvars, ... }:

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

    ] ++ lib.optionals ( hostvars.video == "nvidia") [
        ./nvidia.nix #Waiting for the day i can comment this out
    ] ++ lib.optionals (hostvars.laptop) [
        ./power-monitor.nix
    ];
}

