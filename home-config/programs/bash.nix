{ pkgs, ... }:

{
    programs.bash = {
	enable = true;
	initExtra = ''
	fastfetch

	# Brightness Regulator Universal Helper
	bruh() {
	    local operator=$1
	    local value=$2
	    local laptopDisplayMinimunBrightnessValue=50

	    brightnessctl set $value$operator

	    ddcutil --display 1 setvcp 10 "$operator" "$value"

	    #The choice to make the lowest value possible on the laptop screen be "50" was made because 50 is equal to my main monitor 0 value;
	    #Guess i will have to change this if i ever get another laptop
	    local currentLaptopDisplayBrightnessValue=$(brightnessctl get)

	    if [ "$currentLaptopDisplayBrightnessValue" -lt "$laptopDisplayMinimunBrightnessValue" ]; then
		brightnessctl set $laptopDisplayMinimunBrightnessValue
	    fi
	}

	'';
	shellAliases = {
	    nvimnix = "sudo nvim /etc/nixos/configuration.nix";
	};
    };
}
