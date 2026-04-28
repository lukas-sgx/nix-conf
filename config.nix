{ config, pkgs, lib, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 2;

    boot.kernelPackages = pkgs.linuxPackages;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    services.fprintd.enable = true;

    security.pam.services = {
        login.fprintAuth = lib.mkForce true;
        sudo.fprintAuth = false;
        polkit-1.fprintAuth = true;
        gdm-fingerprint.fprintAuth = true;
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

    services.thermald.enable = true;
    powerManagement.enable = true;

    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";
    console.keyMap = "fr";

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.displayManager.autoLogin.user = "Lukas";
    services.xserver.xkb = {
        layout = "fr";
        variant = "";
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    services.openssh = {
        enable = true;
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
    };

    programs.fish.enable = true;

    users.users.lukas = {
        isNormalUser = true;
        description = "Lukas";
        extraGroups = [ "wheel" "networkmanager" "docker" ];
        shell = pkgs.fish;
    };
  
    programs.dconf.enable = true;

    services.accounts-daemon.enable = true;
    environment.etc."AccountsService/users/root".text = ''
    	[User]
    	SystemAccount=true
    '';

    environment.systemPackages = with pkgs; [
        nix-prefetch-github

        git
        curl
        vim
        htop
        gnome-tweaks
        gnomeExtensions.appindicator
        python3
        libgtop

        gcc
        llvmPackages_20.clang
        llvmPackages_20.llvm
        gcovr
        criterion
        valgrind
        gnumake42
        xhost
        gsettings-desktop-schemas
    ];
    
    environment.variables = {
        GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
    };
    
    hardware.enableRedistributableFirmware = true;

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

    system.stateVersion = "26.05";
}
