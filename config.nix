{ config, pkgs, lib, inputs, ... }:

let env = import ./env.nix;
in {
    imports = [
      ./hardware-configuration.nix
      inputs.impermanence.nixosModules.impermanence
      ./modules/boot.nix
      ./modules/persist.nix
      ./modules/hyprland.nix
      ./modules/sddm.nix
      ./modules/audio.nix
    ];
  
    nixpkgs.config.allowUnfree = true;
  
    networking.hostName = env.hostName;
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "none";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  
    services.fprintd.enable = true;
    security.pam.services = {
        login.fprintAuth    = lib.mkForce true;
        sudo.fprintAuth     = false;
        polkit-1.fprintAuth = true;
    };
  
    services.thermald.enable = true;
    powerManagement.enable = true;
  
    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";
    console.keyMap = "fr";
  
    services.xserver.xkb = {
        layout = "fr";
        variant = "";
    };
  
    services.openssh = {
        enable = true;
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
    };
  
    programs.fish.enable = true;
    programs.dconf.enable = true;
  
    users.users.${env.username} = {
      isNormalUser = true;
      description = env.descriptionName;
      extraGroups = [ "wheel" "networkmanager" "docker" "video" "input" ];
      shell = pkgs.fish;
    };
  
    environment.systemPackages = with pkgs; [
        git curl vim htop
        python3 gnupg gcc
        llvmPackages_20.clang
        llvmPackages_20.llvm
        gcovr criterion valgrind
        gnumake42
        nix-prefetch-github
    ];
  
    virtualisation.docker.enable = true;
  
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
  
    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses; # ← plus de gnome3
        settings = {
          default-cache-ttl = 34560000;
          max-cache-ttl = 34560000;
        };
    };
  
    system.stateVersion = env.nixVersion;
}