{ self, pkgs, inputs, lib, config, ... }: {
  services.fprintd.enable = true;

  security.pam.services = {
      login.fprintAuth = lib.mkForce true;
      sudo.fprintAuth = false;
      polkit-1.fprintAuth = true;
      gdm-fingerprint.fprintAuth = true;
  };
}