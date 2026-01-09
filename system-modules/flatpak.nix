{ config, pkgs, ... }:

{
    imports = [
        "${builtins.fetchTarball "https://github.com/gmodena/nix-flatpak/archive/v0.5.2.tar.gz"}/modules/nixos.nix"
    ];

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
	    "dev.bragefuglseth.Keypunch"
	    "org.gnome.Boxes"
            "net.nokyan.Resources"

            # --- Gaming ---
            "com.heroicgameslauncher.hgl"
            "org.vinegarhq.Sober"
        ];
    };
}
