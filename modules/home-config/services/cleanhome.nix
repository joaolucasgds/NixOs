{ ... }:

{
    systemd.user.tmpfiles.rules = [
        "d      %h/Downloads         -    -    -     7d   -"
        #Maybe add more directories to clean? this could prove to be a really useful tool for system maintenance
    ];
}

