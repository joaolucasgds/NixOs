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
	ffmpeg #no idea how many times i installed this using nix-shell
	tree
  ];

  #Programs that need system-level configuration
  
  # Nautilus extension
    programs.nautilus-open-any-terminal = {
	enable = true;
	terminal = "alacritty";
    };

  # Gaming
  programs.steam = {
    enable = true;
  };

  programs.gamemode.enable = true;
}
