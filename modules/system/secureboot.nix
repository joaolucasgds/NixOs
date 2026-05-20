{ inputs, pkgs, hostvars, ... }: 

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

    boot.loader.timeout = hostvars.bootloaderTimeout;
  
    environment.systemPackages = [ pkgs.sbctl ];
}

