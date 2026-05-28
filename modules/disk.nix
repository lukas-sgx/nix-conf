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

    fileSystems."/swap" = {
        device  = "/dev/disk/by-label/nixos";
        fsType  = "btrfs";
        options = [ "subvol=@swap" "noatime" ];
    };

    fileSystems."/boot" = {
        device  = "/dev/disk/by-label/ESP";
        fsType  = "vfat";
        options = [ "fmask=0077" "dmask=0077" "umask=0077" ];
    };

    swapDevices = [{
        device = "/swap/swapfile";
    }];
}