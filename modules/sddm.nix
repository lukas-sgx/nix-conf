{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable      = true;
    wayland.enable = true;
    theme       = "catppuccin-sddm";
    package     = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = with pkgs; [
    catppuccin-sddm
    kdePackages.qtwayland
    kdePackages.qt5compat
  ];
}