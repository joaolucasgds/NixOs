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
    
    nixpkgs.config.allowUnfree = true;
    
    #Programming

    #Tool
    
    home.stateVersion = "25.11";
  };
}
