{ config, lib, ... }:

{
  xdg.configFile."DankMaterialShell/zen.css".source = ./path/to/your/local/zen.css;

  home.activation = {
    linkZenThemes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PROFILE_DIR=$(find ${config.home.homeDirectory}/.zen -maxdepth 1 -type d -name "*.Default Profile" | head -n 1)

      if [ -n "$PROFILE_DIR" ]; then
        mkdir -p "$PROFILE_DIR/chrome"
        
        ln -sf "${config.home.homeDirectory}/.config/DankMaterialShell/zen.css" "$PROFILE_DIR/chrome/userChrome.css"
      fi
    '';
  };
}
