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

    #Automatically activate extensions
    dconf.settings = {
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
      "org/gnome/shell/extensions/blur-my-shell" = {
      };
    };

    programs.bash.enable = true;
    home.stateVersion = "25.11";
  };
}
