{
  self,
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib

    glibc
    llvmPackages_21.libcxx
    llvmPackages_21.libllvm
  ];
}
