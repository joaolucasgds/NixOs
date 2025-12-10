{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  # (Optional: You can remove this line if it's already in configuration.nix)
  users.users.jl.isNormalUser = true; 

  home-manager.users.jl = { pkgs, ... }: {
    
    home.packages = with pkgs; [ 

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

    home.stateVersion = "25.11";
  };
}
