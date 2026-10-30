__:

{
    networking.firewall = rec {
        enable = true;

        # Minecraft and Android-Mic
        allowedTCPPorts = [ 25565 54345 ];
        allowedUDPPorts = allowedTCPPorts;

        #KDE Connect
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = allowedTCPPortRanges;
    };
}

