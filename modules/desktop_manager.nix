{ self, pkgs, inputs, lib, config, ... }:
let
  env = import ../env.nix;
in {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
      layout = "fr";
      variant = "";
  };
  
  programs.dconf.enable = true;

  environment.variables = {
      GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.system-monitor
    gsettings-desktop-schemas
    libgtop
  ];
}