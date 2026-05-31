{ config, pkgs, lib, inputs, ... }:

let
    env = import ./env.nix;
in
{
    imports = [
        ./hardware-configuration.nix
        ./modules/boot.nix
        ./modules/bluetooth.nix
        ./modules/audio.nix
        ./modules/fingerprint.nix
        ./modules/network.nix
        ./modules/persist.nix
        ./modules/desktop_manager.nix
        ./modules/gpg.nix
        ./modules/locale.nix
        ./modules/linker.nix
    ];

    nixpkgs.config.allowUnfree = true;

    services.thermald.enable = true;
    powerManagement.enable = true;

    programs.fish.enable = true;

    users.users.${env.username} = {
        isNormalUser = true;
        description = env.descriptionName;
        extraGroups = [ "wheel" "networkmanager" "docker" ];
        shell = pkgs.fish;
    };

    services.accounts-daemon.enable = true;

    environment.systemPackages = with pkgs; [
        nh
        git
        curl
        vim
        gnupg
        neovim
        htop

        gcc
        llvmPackages_20.clang
        llvmPackages_20.llvm
        gcovr
        criterion
        valgrind
        gnumake42
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

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

    programs.direnv.enable = true;

    system.stateVersion = env.nixVersion;
}
