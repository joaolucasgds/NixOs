{ pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        
        # --- System & Hardware Utilities ---
        ddcutil             # Monitor brightness control
        brightnessctl       # Laptop screen brightness control
        ffmpeg              # Multimedia processing
        tree                # Directory visualization
        wl-clipboard        # Command line clipboard (Wayland)

        # --- Development & Git ---
        git
        lazygit             # Terminal UI for git
        ripgrep             # Fast search tool (better grep)
        fd                  # Fast file finder (better find)
        neovim              # Text editor

        # --- Internet & Communication ---
        brave               # Browser
        vesktop             # Custom Discord client
        proton-pass         # Password manager
        protonvpn-gui       # VPN Client
        deluge-gtk          # Torrent client

        # --- Media & Entertainment ---
        pear-desktop        # YouTube Music Client
        veracrypt           # Encryption tool (Commented out: build failure Jan 2026)

        # --- Terminal & Shell ---
        alacritty           # GPU-accelerated terminal
        fastfetch           # System info fetcher

        # --- Gaming ---
        jdk25               # Java for Minecraft
        modrinth-app        # Minecraft Mod Loader
        hydralauncher

        # --- GNOME Extensions ---
        gnomeExtensions.blur-my-shell
        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.gsconnect
        gnomeExtensions.coverflow-alt-tab
        gnomeExtensions.reboottouefi
        gnomeExtensions.dynamic-panel
        gnomeExtensions.gamebar-overlay
        gnomeExtensions.hide-top-bar
        gnomeExtensions.search-light
        gnomeExtensions.brightness-control-using-ddcutil
        gnomeExtensions.do-not-disturb-while-screen-sharing-or-recording
        gnomeExtensions.focus-follows-workspace
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"

        "modrinth-app"
        "modrinth-app-unwrapped"

        "veracrypt"

        "steam"
        "steam-unwrapped"
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
}
