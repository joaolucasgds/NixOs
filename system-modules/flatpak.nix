{ config, pkgs, ... }

let
  nix-flatpak = builtins.fetchTarball {
    url = "https://github.com/gmodena/nix-flatpak/archive/main.tar.gz";
  };
in

{
    services.flatpak = {
	enable = true;

	uninstallUnmanaged = true; 

	update.auto = {
	    enable = true;
	    onCalendar = "weekly"; 
	};

	packages = [
	    # --- Browsing & Media ---
	    "app.zen_browser.zen"
	    "io.freetubeapp.FreeTube"
	    "com.github.iwalton3.jellyfin-media-player"

	    # --- Tools & Utilities ---
	    "com.dec05eba.gpu_screen_recorder"          
	    "app.drey.Warp"                             
	    "net.nokyan.Resources"                     

	    # --- Gaming ---
	    "com.heroicgameslauncher.hgl"               
	    "org.vinegarhq.Sober"                      
	];
    };
}
