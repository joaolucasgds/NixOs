{ pkgs, lib, inputs, hostvars, ... }:

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
        warp
        motrix
        pulseaudio

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
        heroic
        keypunch

    ] ++ lib.optionals (hostvars.video == "nvidia") [
        (symlinkJoin {
            name = "modrinth-app-wayland-fix";
            paths = [ modrinth-app ];
            buildInputs = [ makeWrapper ];
            postBuild = ''
                wrapProgram $out/bin/ModrinthApp \
                --set WEBKIT_DISABLE_DMABUF_RENDERER 1
            '';
        })
    ] ++ lib.optionals (hostvars.video != "nvidia") [
        modrinth-app
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"

        "veracrypt"

        "modrinth-app"
        "modrinth-app-unwrapped"

        "steam"
        "steam-unwrapped"

        "android-studio"
    ];

    # --- System Configured Programs ---

    programs = {
        gpu-screen-recorder = {
            enable = true;
        };

        virt-manager = {
            enable = true;
        };

        # Gaming Optimization
        gamemode.enable = true;

        # Steam Platform
        steam = {
            enable = true;
        };
    };
}
