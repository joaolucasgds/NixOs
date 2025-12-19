{ pkgs, ... }:

{
    home.packages = with pkgs; [ 
	  #Programming
	  neovim
	  ripgrep 
	  fd    
	  xclip 
	  wl-clipboard
	  
	  #Proton
	  proton-pass	
	  
	  #Tools
	  deluge-gtk
	  veracrypt

	  #Social
	  vesktop
	  modrinth-app
	  youtube-music
	  brave

	  #Gnome extensions
	  gnomeExtensions.blur-my-shell
	  gnomeExtensions.caffeine
	  gnomeExtensions.clipboard-indicator
	  gnomeExtensions.gsconnect
	  gnomeExtensions.coverflow-alt-tab
	  gnomeExtensions.reboottouefi
	  gnomeExtensions.dynamic-panel
	  gnomeExtensions.gamebar-overlay
	  gnomeExtensions.hide-top-bar
	  gnomeExtensions.hide-the-dock-in-overview
	  gnomeExtensions.search-light
	  gnomeExtensions.brightness-control-using-ddcutil
	  gnomeExtensions.do-not-disturb-while-screen-sharing-or-recording
	  gnomeExtensions.focus-follows-workspace

    ]; 
}

