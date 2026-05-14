{ pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        
        # --- System & Hardware Utilities ---
        ddcutil             # Monitor brightness control
        brightnessctl       # Laptop screen brightness control
        ffmpeg              # Multimedia processing
        tree                # Directory visualization
        wl-clipboard        # Command line clipboard (Wayland)
        fastfetch

        # --- Development & Git ---
        ripgrep             # Fast search tool (better grep)
        fd                  # Fast file finder (better find)
        android-studio
        gradle
        virt-manager
        qemu
        yazi

        # --- Internet & Communication ---
        brave               # Browser
        proton-pass         # Password manager
        protonvpn-gui       # VPN Client
        deluge-gtk          # Torrent client

        # --- Media & Entertainment ---
        pear-desktop        # YouTube Music Client
        veracrypt           # Encryption tool (Commented out: build failure Jan 2026)


        # --- Gaming ---
        jdk25               # Java for Minecraft
        modrinth-app        # Minecraft Mod Loader

    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"

        "modrinth-app"
        "modrinth-app-unwrapped"

        "veracrypt"

        "steam"
        "steam-unwrapped"

        "android-studio"
    ];

    # --- System Configured Programs ---

    # Open terminal from Nautilus context menu
    programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "alacritty";
    };

    # Gaming Optimization
    programs.gamemode.enable = true;

    # Steam Platform
    programs.steam = {
        enable = true;
    };

    programs.kdeconnect.enable = true;
}
