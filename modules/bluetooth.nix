{ self, pkgs, inputs, lib, config, ... }: {
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}