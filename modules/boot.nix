{ self, pkgs, inputs, lib, config, ... }: {
    services.fwupd.enable = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 2;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    
    security.auditd.enable = true;
    security.audit.enable = true;
    boot.kernel.sysctl = {
        "kernel.kptr_restrict" = 2;
        "kernel.dmesg_restrict" = 1;
        "net.ipv4.conf.all.rp_filter" = 1;
    };
}
