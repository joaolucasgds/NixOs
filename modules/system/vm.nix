{ pkgs, ... }:

{
    
    programs.virt-manager.enable = true;
    environment.systemPackages = [ pkgs.qemu ];
    users.users.jl.extraGroups = [ "libvirtd" ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    # virtualisation.waydroid = {
    #     enable = true;
    #     package = pkgs.waydroid-nftables;
    # };
}

