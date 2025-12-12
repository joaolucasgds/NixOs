{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	gpu-screen-recorder
	lazygit
	ddcutil
	jdk25
	protonvpn-gui
  ];

  #Programs that need system-level configuration
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Joao Lucas Gomes de Souza";
        email = "joaolucasgdesouza@gmail.com";
      };
    };
  };

  # Gaming
  programs.steam = {
    enable = true;
  };

  programs.gamemode.enable = true;
}
