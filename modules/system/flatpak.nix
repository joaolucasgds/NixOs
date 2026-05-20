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
            "app.drey.Warp"
	        "dev.bragefuglseth.Keypunch"
            "com.pikatorrent.PikaTorrent"
            "org.gnome.SoundRecorder"

            # --- Gaming ---
            "org.vinegarhq.Sober"
            "com.heroicgameslauncher.hgl"
            "com.modrinth.ModrinthApp"
        ];
    };
}
