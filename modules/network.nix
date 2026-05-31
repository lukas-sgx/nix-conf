{ self, pkgs, inputs, lib, config, ... }:
let
    env = import ../env.nix;
in {
  networking.hostName = env.hostName;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
}