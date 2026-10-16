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

  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    dnssec = "allow-downgrade";
    
    settings.Resolve = {
      MulticastDNS = "no";
      LLMNR = "no";
      Domains = [ "~." ];
    };
  };

  networking.nameservers = [
    "1.1.1.1#cloudflare-dns.com"
    "1.0.0.1#cloudflare-dns.com"
  ];

  networking.networkmanager.wifi.macAddress = "stable";
  networking.networkmanager.ethernet.macAddress = "stable";
}