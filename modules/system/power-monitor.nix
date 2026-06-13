__:

{
    services.acpid.handlers = {
        ac-disconnect = {
            event = "ac_adapter.*00000000";
            action = "/run/current-system/sw/bin/shutdown +2 'AC disconnected. Shutting down in 2 minutes.'";
        };
        
        ac-connect = {
            event = "ac_adapter.*00000001";
            action = "/run/current-system/sw/bin/shutdown -c";
        };
    };
}
