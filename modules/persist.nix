{ lib, ... }:
let env = import ../env.nix;
in {
    environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/docker"
          "/etc/NetworkManager/system-connections"
          "/etc/ssh"
        ];
        users.${env.username} = {
            directories = [
              "Documents"
              "Pictures"
              "Videos"
              "Downloads"
              ".ssh"
              ".gnupg"
              ".config"
              ".cache/zen"
              ".mozilla"
              ".local/share/keyrings"
              ".local/share/gnupg"
              "epitech"
            ];
        };
    };
}