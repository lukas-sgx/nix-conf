{ pkgs, ... }: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  
    # environment.sessionVariables = {
    #   NIXOS_OZONE_WL  = "1";
    #   MOZ_ENABLE_WAYLAND = "1";
    #   WLR_NO_HARDWARE_CURSORS = "1";
    #   LIBVA_DRIVER_NAME = "iHD";
    # };
  
    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
        config.common.default = "*";
    };

    environment.systemPackages = with pkgs; [
        waybar
        dunst
        libnotify
        rofi-wayland
        wl-clipboard
        hyprpaper
        hyprlock
        grim
        slurp
        brightnessctl
        playerctl
    ];
}