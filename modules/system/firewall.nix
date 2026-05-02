{ ... }:

{
    networking.firewall = rec {
        enable = true;

        # Minecraft
        allowedTCPPorts = [ 25565 ];
        allowedUDPPorts = allowedTCPPorts;

        #KDE Connect
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = allowedTCPPortRanges;
    };
}

