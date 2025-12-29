{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  	tree-sitter
	lazygit
	ddcutil
	brightnessctl
	jdk25
	protonvpn-gui
  ];

  #Programs that need system-level configuration
  # Gaming
  programs.steam = {
    enable = true;
  };

  programs.gamemode.enable = true;
}
