{ ... }:

{
    programs.hyprland = {
        enable = true;
        withUWSM = false;
        xwayland.enable = true;
    };

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };

    hardware = {
        opengl.enable = true;
        nvidia.modesetting.enable = true;
    };
}

