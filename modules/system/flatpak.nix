{ inputs, ... }:

{
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak = {
        enable = true;

        update.auto = {
            enable = true;
            onCalendar = "weekly";
        };

        uninstallUnmanaged = true;

        packages = [
            # --- Browsing & Media ---
            "io.freetubeapp.FreeTube"
            "org.jellyfin.JellyfinDesktop"

            # --- Tools & Utilities ---
            "com.dec05eba.gpu_screen_recorder"
            "app.drey.Warp"
	        "dev.bragefuglseth.Keypunch"
            "com.pikatorrent.PikaTorrent"

            # --- Gaming ---
            "org.vinegarhq.Sober"
            "com.heroicgameslauncher.hgl"
            "com.modrinth.ModrinthApp"
        ];
    };
}
