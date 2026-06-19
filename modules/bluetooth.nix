{ self, pkgs, inputs, lib, config, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;
}