{ config, pkgs, zen-browser, system, lib, inputs, ... }:
let
  env = import ../../env.nix;
in {
  programs.git = {
      enable = true;
      settings = {
          user.name = env.gitUser;
          user.email = env.gitEmail;
          user.signingkey = env.gpgSign;
          init.defaultBranch = "main";
          pull.rebase = false;
          commit.gpgsign = true;
          tag.gpgSign = true;
      };
  };
}