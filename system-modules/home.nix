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
    programs.bash = {
      enable = true;
      initExtra = ''echo "Welcome to NixOs"'';
      shellAliases = {
      	nvimnix = "sudo nvim /etc/nixos/configuration.nix";
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
      	
	window = {
	  opacity = 0.1;
	  blur = true;
	  decorations = "None";
	  padding = {
	    x = 8;
	    y = 8;
	  };
	};

	font = {
	  size = 13.0;
	  
	  normal = {
	    family = "FiraCode Nerd Font";
	    style = "Regular";
	  };

	  bold = {
	    family = "FiraCode Nerd Font";
	    style = "bold";
	  };
	
	  italic = {
	    family = "FiraCode Nerd Font";
	    style = "italic";
	  };
	};

	colors = {

	  primary = {
            background = "#000000";
	    foreground = "#f0f0f0";
	  };

	  cursor = {
	    text = "#000000";
	    cursor = "#ffffff";
	  };

	  normal = {
	    black = "#1c1c1c";
	    red = "#ff5f5f";
	    green = "#5fff87";
	    yellow = "#ffd75f";
	    blue = "#5fafff";
	    magenta = "#ff5fff";
	    cyan = "#5fffff";
	    white = "#e4e4e4";
	  };

	  bright = {
	    black = "#3a3a3a";
	    red = "#ff8787";
	    green = "#87ffaf";
	    yellow = "#ffdf87";
	    blue = "#87caff";
	    magenta = "#ff87ff";
	    cyan = "#87ffff";
	    white = "#ffffff";
          };
        };

	cursor = {
	  style = "Beam";
	};

	selection = {
      	  save_to_clipboard = true;
	};
	  
	mouse = {
	  hide_when_typing = true;
	};
      };
    };

    programs.lazygit = {
      enable = true;
    };

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
