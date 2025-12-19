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

    programs.git = {
      enable = true;
      userName = "Joao Lucas Gomes de Souza"; 
      userEmail = "joaolucasgdesouza@gmail.com";
    };

    #Tool
    programs.fastfetch = {
      enable = true;
      settings = {
	logo = {
	  padding = {
	    top = 2;
	    left = 1;
	    right = 2;
	  };
	  color = {
	    "1" = "white";
	    "2" = "white";
	    "3" = "white";
	    "4" = "white";
	    "5" = "white";
	    "6" = "white";
	    "7" = "white";
	    "8" = "white";
	    "9" = "white";
	  };
	};
	display = {
	  color = "black";
	};
	modules = [
	  {
	    type = "title";
	    color = {
	      user = "black";
	      at = "black";
	      host = "white";
	    };
	  }
	  "separator"
	  "os"
	  "host"
	  "kernel"
	  "uptime"
	  "packages"
	  "shell"
	  "display"
	  "de"
	  "wm"
	  "wmtheme"
	  "theme"
	  "icons"
	  "font"
	  "cursor"
	  "terminal"
	  "terminalfont"
	  "cpu"
	  "gpu"
	  "memory"
	  "swap"
	  "disk"
	  "localip"
	  "battery"
	  "poweradapter"
	  "locale"
	  "break"
	  "colors"
	];
      };
    };

    home.stateVersion = "25.11";
  };
}
