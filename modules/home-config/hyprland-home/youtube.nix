{ pkgs, ... }:

{
    home.packages = [
        (pkgs.writeShellScriptBin "youtube" ''
            configDir="''${XDG_CONFIG_HOME:-$HOME/.config}"
            palette="$configDir/gtk-3.0/dank-colors.css"
            conf="$configDir/pipe-viewer/gtk-pipe-viewer.conf"

            if [[ -r "$palette" && -f "$conf" ]]; then
                accent=$(${pkgs.gawk}/bin/awk '
                    $1 == "@define-color" && $2 == "accent_color" {
                        sub(/;$/, "", $3)
                        if ($3 ~ /^#[[:xdigit:]]{6}$/) color = $3
                    }
                    END { print color }
                ' "$palette")

                if [[ -n "$accent" ]]; then
                    ${pkgs.gnused}/bin/sed -i -E \
                        "s/(watch_history_color[[:space:]]*=>[[:space:]]*)\"[^\"]*\"/\1\"$accent\"/" \
                        "$conf"
                fi
            fi

            exec gtk-pipe-viewer "$@"
        '')
    ];
}
