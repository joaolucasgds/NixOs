{ pkgs, ... }:

{
    home.packages = [
	    (pkgs.writeShellScriptBin "bruh" ''
            operator=$1
            value=$2
            laptopDisplayMinimunBrightnessValue=50

            # KILL previous instances so they don't fight for the I2C bus
            pkill -f "ddcutil --display 1 setvcp 10" || true

            ${pkgs.brightnessctl}/bin/brightnessctl set $value$operator

            ${pkgs.ddcutil}/bin/ddcutil --display 1 setvcp 10 "$operator" "$value" > /dev/null 2>&1 &

            #The choice to make the lowest value possible on the laptop screen be "50" was made because 50 is equal to my main monitor 0 value;
            #Guess i will have to change this if i ever get another laptop
            currentLaptopDisplayBrightnessValue=$(${pkgs.brightnessctl}/bin/brightnessctl get)

            if [ "$currentLaptopDisplayBrightnessValue" -lt "$laptopDisplayMinimunBrightnessValue" ]; then
            ${pkgs.brightnessctl}/bin/brightnessctl set $laptopDisplayMinimunBrightnessValue
            fi
        '')
    ];
}
