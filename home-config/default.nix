{ pkgs, ... }:

{
    imports = [
	#Core
	./homepkgs.nix
	./dconf.nix
	./xdg.nix
	./wallpapers.nix

	#Systemd services
	./services/gpu-screen-recorder.nix

	#Programs
	./programs/alacritty.nix
	./programs/bash.nix
	./programs/fastfetch.nix
	./programs/git.nix
	./programs/lazygit.nix
	./programs/vesktop.nix
	./programs/bruh.nix
	./programs/nautilus-extensions.nix
    ];
}

