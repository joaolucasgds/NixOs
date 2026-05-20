{ pkgs, lib, inputs, ... }:

{

    environment.systemPackages = with pkgs; [
        
        # --- System & Hardware Utilities ---
        ddcutil             # Monitor brightness control
        brightnessctl       # Laptop screen brightness control
        ffmpeg              # Multimedia processing
        tree                # Directory visualization
        wl-clipboard        # Command line clipboard (Wayland)
        fastfetch
        inputs.gsr-ui-nix.packages.${pkgs.system}.gpu-screen-recorder-notification
        killall
        jq

        # --- Development & Git ---
        ripgrep             # Fast search tool (better grep)
        fd                  # Fast file finder (better find)
        android-studio
        gradle
        qemu

        # --- Internet & Communication ---
        brave               # Browser
        proton-pass         # Password manager
        proton-vpn           # VPN Client

        # --- Media & Entertainment ---
        pear-desktop        # YouTube Music Client
        veracrypt           # Encryption tool (Commented out: build failure Jan 2026)

    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"

        "veracrypt"

        "steam"
        "steam-unwrapped"

        "android-studio"
    ];

    # --- System Configured Programs ---

    programs.gpu-screen-recorder = {
        enable = true;
    };

    programs.virt-manager = {
        enable = true;
    };

    # Gaming Optimization
    programs.gamemode.enable = true;

    # Steam Platform
    programs.steam = {
        enable = true;
    };
}
