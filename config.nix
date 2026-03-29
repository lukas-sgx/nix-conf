{ config, pkgs, lib, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 10;

    boot.kernelPackages = pkgs.linuxPackages;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
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

    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        displayManager.gdm.autoLogin.user = "Lukas";
	    xkb = {
            layout = "fr";
            variant = "";
        };
    };

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
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
   
    services.accounts-daemon.enable = true;
    environment.etc."AccountsService/users/root".text = ''
    	[User]
    	SystemAccount=true
    '';

    environment.systemPackages = with pkgs; [
        git
        curl
        wget
        vim
        htop
        gnome-tweaks
        gnomeExtensions.appindicator
        python3
        libgtop
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
