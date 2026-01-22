{ inputs, pkgs, lib, ... }: 

{
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
    
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

