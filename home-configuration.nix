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

  nixpkgs.config.allowUnfree = true;

  home-manager.users.jl = { pkgs, ... }: {
    
    home.packages = with pkgs; [ 
      #Programing
      neovim
      ripgrep 
      fd    
      xclip 
      wl-clipboard
      
      #Proton
      proton-pass

      #Social
      vesktop
      modrinth-app

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

    dconf.settings = {

      #Automatically activate extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          caffeine.extensionUuid
          clipboard-indicator.extensionUuid
          gsconnect.extensionUuid
          coverflow-alt-tab.extensionUuid
          reboottouefi.extensionUuid
          dynamic-panel.extensionUuid
          gamebar-overlay.extensionUuid
          hide-top-bar.extensionUuid
          hide-the-dock-in-overview.extensionUuid
          search-light.extensionUuid
        ];
      };

      #Config Extensions
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = false;
      };

      "org/gnome/shell/extensions/clipboard-indicator" = {
	excluded-apps = ["Proton Pass"];
      };

      "org/gnome/shell/extensions/search-light" = {
        shortcut-search = ["<Control><Alt>a"];
      };

      #Config Custom Keybinds   There must be a better way of doing this instead of repeating myself like this  
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
	  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
	  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
	  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
        ];
      };

      # Terminal
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Terminal";
        command = "kgx";
        binding = "<Control><Alt>t";
      };

      # Browser
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "Browser";
        command = "flatpak run app.zen_browser.zen";
        binding = "<Control><Alt>n";
      };

      # ProtonPass
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "ProtonPass";
        command = "proton-pass";
        binding = "<Control><Alt>p";
      };

      # Discord (Vesktop)
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        name = "Discord";
        command = "vesktop"; 
        binding = "<Control><Alt>d";
      };

      # Neovim
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
        name = "Neovim";
        command = "nvim"; 
        binding = "<Control><Alt>v";
      };

      # Kodi
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
        name = "Kodi";
        command = "kodi";
        binding = "<Control><Alt>k";
      };

      # Files
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
        name = "Files";
	command = "nautilus";
	binding = "<Control><Alt>f";
      };

      # Settings
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" = {
 	name = "Settings";
	command = "gnome-control-center";
	binding = "<Control><Alt>s";
      };

      # ProtonVPN
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" = {
        name = "ProtonVPN";
	command = "protonvpn-app";
	binding = "<Control><Alt>j";
      };

      #GNOME CORE & INTERFACE

      # Search Provider Order (Calculator First)
      "org/gnome/desktop/search-providers" = {
        sort-order = [
          "org.gnome.Calculator.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.Contacts.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };

      # Disable Mouse Acceleration
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      # Interface: Dark Mode, Blue Accent, 12h Clock
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "blue";
        clock-format = "12h";
      };

    };
    
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
	  opacity = 0.0;
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

    home.stateVersion = "25.11";
  };
}
