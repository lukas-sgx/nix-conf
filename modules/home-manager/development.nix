{ config, pkgs, zen-browser, system, lib, inputs, ... }:
{
  home.packages = (with pkgs; [
    vscode
    zed-editor

    devenv
    gh
    openvpn
    go
    rustup
    cargo-watch
    tmux
    qemu

    kind
    kubectl

    llvmPackages_20.clang
    llvmPackages_20.llvm
    gcovr
    criterion
    valgrind
    gnumake42
  ]);

  programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.userSettings = {
          "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
          "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
      };
  };
  
  programs.direnv.enable = true;
}