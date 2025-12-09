{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  users.users.jl.isNormalUser = true;
  home-manager.users.jl = { pkgs, ... }: {
    home.packages = [ 

      #Gnome extensions
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.gsconnect
      gnomeExtensions.coverflow-alt-tab
      gnomeExtensions.reboottouefi
      gnomeExtensions.dynamic-panel
      gnomeExtensions.gamebar-overlay
      gnomeExtensions.hide-top-bar
      gnomeExtensions.hide-the-dock-in-overview
      gnomeExtensions.search-light

    ];
    programs.bash.enable = true;

    home.stateVersion = "25.11";
  };
}

