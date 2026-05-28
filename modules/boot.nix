{ pkgs, lib, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 2;
    boot.kernelPackages = pkgs.linuxPackages;
  
    boot.initrd.postDeviceCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount /dev/disk/by-label/nixos /btrfs_tmp
    
        if [[ -e /btrfs_tmp/@ ]]; then
          btrfs subvolume delete /btrfs_tmp/@
        fi
    
        btrfs subvolume snapshot /btrfs_tmp/@blank /btrfs_tmp/@
    
        umount /btrfs_tmp
    '';
}