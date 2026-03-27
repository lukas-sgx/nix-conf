{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    hardware.opengl = {
        enable = true;
        extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        ];
    };

    services.thermald.enable = true;
    services.power-profiles-daemon.enable = false;
    services.tlp = {
        enable = true;
        settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        };
    };
    powerManagement.enable = true;

    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";
    console.keyMap = "fr";

    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
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

    programs.zsh.enable = true;

    users.users.lukas = {
        isNormalUser = true;
        description = "Lukas Soigneux";
        extraGroups = [ "wheel" "networkmanager" "docker" ];
        shell = pkgs.zsh;
    };

    environment.systemPackages = with pkgs; [
        git
        curl
        wget
        vim
        htop
        gnome-tweaks
        gnomeExtensions.appindicator
    ];

    hardware.enableRedistributableFirmware = true;

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
    };
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
    };

    system.stateVersion = "24.11";
}