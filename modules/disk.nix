{ ... }: {
    fileSystems."/" = {
        device  = "/dev/disk/by-label/nixos";
        fsType  = "btrfs";
        options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

    fileSystems."/persist" = {
        device        = "/dev/disk/by-label/nixos";
        fsType        = "btrfs";
        options       = [ "subvol=@persist" "compress=zstd" "noatime" ];
        neededForBoot = true;
    };

    fileSystems."/boot" = {
        device  = "/dev/disk/by-label/BOOT";
        fsType  = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
}