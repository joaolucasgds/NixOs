{ pkgs, ... }:

{
    imports = [
	#Core
	./homepkgs.nix
	./dconf.nix
	./xdg.nix

	#Programs
	./programs/alacritty.nix
	./programs/bash.nix
	./programs/fastfetch.nix
	./programs/git.nix
	./programs/lazygit.nix
	./programs/mpv.nix
	./programs/bruh.nix
	./programs/nautilus-extensions.nix
    ];
}

