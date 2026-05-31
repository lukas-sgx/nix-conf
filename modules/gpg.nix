{ self, pkgs, inputs, lib, config, ... }: {
  programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      settings = {
          default-cache-ttl = 34560000;
          max-cache-ttl = 34560000;
      };
  };
}