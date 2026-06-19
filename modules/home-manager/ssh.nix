{ config, pkgs, zen-browser, system, lib, inputs, ... }:
{
  programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*".addKeysToAgent = "yes";
      settings."*".hashKnownHosts = "yes";
  };
}