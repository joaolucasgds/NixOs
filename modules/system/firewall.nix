{ ... }:

{
    networking.firewall = rec {
        enable = true;

        #KDE Connect
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = allowedTCPPortRanges;
    };
}

