{ pkgs, ... }:

{
    systemd.user = {
        services = {
            downloads-cleaner = {
                Unit = {
                    Description = "Delete Downloads older than 7 days (Ignoring Access Time)";
                };

                Service = {
                    Type = "oneshot";
                    # EXPLANATION:
                    # -maxdepth 1: Only look at the files/folders sitting directly in Downloads
                    # -mindepth 1: Don't delete the "Downloads" folder itself
                    # -mtime +7:  Check ONLY if 'Modified' > 7 days ago (Ignores Access Time)
                    # -exec rm -rf: Forcefully cut the neck of anything found
                    ExecStart = "${pkgs.findutils}/bin/find -P %h/Downloads -xdev -maxdepth 1 -mindepth 1 -mtime +6 -print -exec ${pkgs.coreutils}/bin/rm -rf -- {} +";

                    NoNewPrivileges = true;
                    PrivateTmp = true;
                    ProtectSystem = "strict";
                    ProtectHome = "read-only";
                    ReadWritePaths = [ "%h/Downloads" ];
                };
            };
            
            screenshots-cleaner = {
                Unit = {
                    Description = "Delete screenshots older than 7 days (Ignoring Access Time)";
                };

                Service = {
                    Type = "oneshot";
                    # EXPLANATION:
                    # -maxdepth 1: Only look at the files/folders sitting directly in Pictures/Screenshots
                    # -mindepth 1: Don't delete the "Screenshots" folder itself
                    # -mtime +7:  Check ONLY if 'Modified' > 7 days ago (Ignores Access Time)
                    # -exec rm -rf: Forcefully cut the neck of anything found
                    ExecStart = "${pkgs.findutils}/bin/find -P %h/Pictures/Screenshots -xdev -maxdepth 1 -mindepth 1 -mtime +6 -print -exec ${pkgs.coreutils}/bin/rm -rf -- {} +";

                    NoNewPrivileges = true;
                    PrivateTmp = true;
                    ProtectSystem = "strict";
                    ProtectHome = "read-only";
                    ReadWritePaths = [ "%h/Pictures/Screenshots" ];
                };
            };
            
            # record.save_directory ${config.home.homeDirectory}/Videos/Temporary
            temporary-videos-cleaner = {
                Unit = {
                    Description = "Delete videos older than 7 days (Ignoring Access Time)";
                };

                Service = {
                    Type = "oneshot";
                    # EXPLANATION:
                    # -maxdepth 1: Only look at the files/folders sitting directly in Videos/Temporary
                    # -mindepth 1: Don't delete the "Temporary" folder itself
                    # -mtime +7:  Check ONLY if 'Modified' > 7 days ago (Ignores Access Time)
                    # -exec rm -rf: Forcefully cut the neck of anything found
                    ExecStart = "${pkgs.findutils}/bin/find -P %h/Videos/Temporary -xdev -maxdepth 1 -mindepth 1 -mtime +6 -print -exec ${pkgs.coreutils}/bin/rm -rf -- {} +";

                    NoNewPrivileges = true;
                    PrivateTmp = true;
                    ProtectSystem = "strict";
                    ProtectHome = "read-only";
                    ReadWritePaths = [ "%h/Videos/Temporary" ];
                };
            };
        };

        timers = {
            downloads-cleaner = {
                Unit = {
                    Description = "Run the cleaner daily";
                };

                Timer = {
                    OnCalendar = "daily";
                    Persistent = true;      # Run immediately if computer was off during the scheduled time
                    RandomizedDelaySec = "5m"; # Avoid spike at startup
                };

                Install = {
                    WantedBy = [ "timers.target" ];
                };
            };

            screenshots-cleaner = {
                Unit = {
                    Description = "Run the cleaner daily";
                };

                Timer = {
                    OnCalendar = "daily";
                    Persistent = true;      # Run immediately if computer was off during the scheduled time
                    RandomizedDelaySec = "5m"; # Avoid spike at startup
                };

                Install = {
                    WantedBy = [ "timers.target" ];
                };
            };

            temporary-videos-cleaner = {
                Unit = {
                    Description = "Run the cleaner daily";
                };

                Timer = {
                    OnCalendar = "daily";
                    Persistent = true;      # Run immediately if computer was off during the scheduled time
                    RandomizedDelaySec = "5m"; # Avoid spike at startup
                };

                Install = {
                    WantedBy = [ "timers.target" ];
                };
            };
        };
    };
}
