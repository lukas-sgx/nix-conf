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
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      # "/var/lib/fprint"
      # "/var/lib/docker"
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
        # ".gnupg"
        ".local/share/fish"
        #".local/share/backgrounds"
        #".local/share/icons"

      ];
    };
    files = [
      #"/etc/machine-id"
    ];
  };
}
