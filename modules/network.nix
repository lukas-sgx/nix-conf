{ self, pkgs, inputs, lib, config, ... }:
let
    env = import ../env.nix;
in {
    networking.firewall.enable = true;
    networking.hostName = env.hostName;
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = lib.mkForce "none";

    services.resolved = {
        enable = true;
        settings.Resolve = {
            dnssec = "true";
            dnsovertls = "true";
            MulticastDNS = "no";
            LLMNR = "no";
        };
    };
    networking.nameservers = [ "1.1.1.1#cloudflare-dns.com" "1.0.0.1#cloudflare-dns.com" ];
    
    networking.networkmanager.wifi.macAddress = "stable";
    networking.networkmanager.ethernet.macAddress = "stable";
}