{ pkgs, lib, ... }: 

let
  lanzaboote-src = builtins.fetchTarball "https://github.com/nix-community/lanzaboote/archive/v1.0.0.tar.gz";
  
  lanzaboote = import lanzaboote-src { inherit pkgs; };
in

{
    imports = [ lanzaboote.nixosModules.lanzaboote ];
    
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
	enable = true;
	pkiBundle = "/var/lib/sbctl";
    
	autoGenerateKeys = {
	    enable = true;
	};

	autoEnrollKeys = {
	    enable = true;
	    includeMicrosoftKeys = true;
	    autoReboot = true;
	};
    };
  
    environment.systemPackages = [ pkgs.sbctl ];
}

