{ config, pkgs, zen-browser, system, lib, inputs, ... }:

let
    env = import ./env.nix;
in  
{
    home.username = env.username;
    home.homeDirectory = env.homeDir;
    home.stateVersion = env.nixVersion;

    imports = [
      ./modules/home-manager/fish.nix
      ./modules/home-manager/git.nix
      ./modules/home-manager/ssh.nix
      ./modules/home-manager/xdg.nix
      ./modules/home-manager/development.nix
    ];

    home.packages = (with pkgs; [
        discord

        gnome-extension-manager
    ]) ++ [
        zen-browser.packages.${system}.default
    ];

    programs.home-manager.enable = true;
}
