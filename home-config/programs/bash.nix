{ pkgs, ... }:

{
    programs.bash = {
	enable = true;
	initExtra = ''echo "Welcome to NixOs"'';
	shellAliases = {
	    nvimnix = "sudo nvim /etc/nixos/configuration.nix";
	};
    };
}
