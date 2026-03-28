{ config, pkgs, zen-browser, system, ... }:

{
    home.username = "lukas";
    home.homeDirectory = "/home/lukas";
    home.stateVersion = "25.05";

    home.packages = (with pkgs; [
        vscode
        llvmPackages_20.clang

        docker-compose
        go
        gnome-extension-manager
        firefox
        discord
        eza
        fzf
        ]) ++ [
        zen-browser.packages.${system}.default
    ];

    programs.git = {
        enable = true;
        userName = "lukas-sgx";
        userEmail = "lukas.soigneux@epitech.eu";
        extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
        };
    };

    programs.zsh = {
        enable = true;
        shellAliases = {
        ll = "ls -la";
        nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
        nfu = "sudo nix flake update /etc/nixos";
        };
    };

    programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";
    };

    programs.home-manager.enable = true;
}