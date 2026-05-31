{ self, pkgs, inputs, lib, config, ... }:
let
  env = import ../env.nix;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/etc/ssh"
    ];
    users.${env.username} = {
        directories = [
            "Documents"
            "Pictures"
            "Videos"
            ".ssh"
            ".config/Code"
            ".config/zen"
            ".cache/zen"
            ".mozilla"
            ".local/share/keyrings"
            "epitech"
        ];
    };
    files = [];
  };
}