{ config, pkgs, ... }:

{
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 5; 

    extraArgs = [
      "-g" # Kill the whole process group (avoids leaving zombie processes)
      "--avoid"
      "^(steam|gamescope|java|minecraft|nvim|neovim)$"
    ];
  };
}
