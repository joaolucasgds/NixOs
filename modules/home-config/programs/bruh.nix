{ pkgs, hostvars, ... }:

{
    home.packages = [
        (pkgs.writeShellScriptBin "bruh" ''
            operator=$1
            value=$2
            displayMBV=${toString hostvars.displayMBV}
            laptopDisplayMBV=${toString hostvars.laptopDisplayMBV}

            # --- 1. External Monitor Control (DDCUtil) ---
            for display in $(${pkgs.ddcutil}/bin/ddcutil detect --brief | awk '/Display/ {print $2}'); do
                currentExt=$(${pkgs.ddcutil}/bin/ddcutil --display "$display" getvcp 10 --brief | awk '{print $4}')

                if [ "$operator" = "+" ]; then
                    targetExt=$((currentExt + value))
                else
                    targetExt=$((currentExt - value))
                fi

                if [ "$targetExt" -lt "$displayMBV" ]; then
                    targetExt=$displayMBV
                fi

                ${pkgs.ddcutil}/bin/ddcutil --display "$display" setvcp 10 "$targetExt" &
                setsid gsr-notify --text "Monitor brightness $targetExt" --timeout 3 --bg-color FFFF00 > /dev/null 2>&1 &
            done

            # --- 2. Laptop Screen Control (Anti-Flicker Logic) ---
            if [ -d "/sys/class/backlight" ] && [ "$(ls -A /sys/class/backlight)" ]; then
            currentVal=$(${pkgs.brightnessctl}/bin/brightnessctl get)

            # Calculate new target
            if [ "$operator" = "+" ]; then
                newVal=$((currentVal + value))
            else
                newVal=$((currentVal - value))
            fi

            # Clamp to minimum
            if [ "$newVal" -lt "$laptopDisplayMBV" ]; then newVal=$laptopDisplayMBV; fi

            # ONLY SET if the value is actually different
            if [ "$newVal" -ne "$currentVal" ]; then
                ${pkgs.brightnessctl}/bin/brightnessctl set "$newVal"
            fi
            fi
        '')
    ];
}
