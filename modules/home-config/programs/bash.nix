{ ... }:

{
    programs.bash = {
	    enable = true;
	    initExtra = ''fastfetch'';
	    shellAliases = {
	        nvimnix = "sudo nvim /etc/nixos/configuration.nix";
	    };
    };
}
