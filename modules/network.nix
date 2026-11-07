{
  self,
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  env = import ../env.nix;
in
{
  networking.firewall.enable = true;
  networking.hostName = env.hostName;
  networking.networkmanager.enable = true;

  networking.networkmanager.dns = "default";

  services.resolved.enable = false;

  networking.networkmanager.wifi.macAddress = "stable";
  networking.networkmanager.ethernet.macAddress = "stable";
}
