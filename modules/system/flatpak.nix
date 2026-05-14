{ inputs, ... }:

{
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak = {
        enable = true;

        update.auto = {
            enable = true;
            onCalendar = "weekly";
        };

        packages = [
            # --- Browsing & Media ---
            "io.freetubeapp.FreeTube"
            "com.github.iwalton3.jellyfin-media-player"

            # --- Tools & Utilities ---
            "com.dec05eba.gpu_screen_recorder"
            "app.drey.Warp"
	        "dev.bragefuglseth.Keypunch"

            # --- Gaming ---
            "org.vinegarhq.Sober"
            "com.heroicgameslauncher.hgl"
            "com.modrinth.ModrinthApp"
        ];
    };
}
