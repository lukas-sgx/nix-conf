{
  config,
  pkgs,
  system,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./epiclang.nix
  ];

  home.packages = (
    with pkgs;
    [
      zed-editor

      devenv
      gh
      go
      rustup
      cargo-watch
      tmux
      qemu

      kubectl
      kubernetes-helm

      gcovr
      criterion
      valgrind
      gnumake42
    ]
  );

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
        "terminal.integrated.stickyScroll.enabled" = false;
        
        "workbench.secondarySidebar.defaultVisibility" = "hidden";
        "workbench.layoutControl.enabled" = false;
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-perfect-macchiato";

        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;

        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = 0.4;

        "github.copilot.enable" = {
          "*" = false;
        };

        "files.exclude" = {
          "**/*.o" = true;
        };

        "files.associations" = {
          "*.h" = "c";
        };

        # "chat.commandCenter.enabled" = false;
        # "chat.titleBar.openInAgentsWindow.enabled" = false;

        "workbench.commandPalette.experimental.suggestCommands" = false;
        "editor.inlineSuggest.enabled" = false;

        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        "security.workspace.trust.enabled" = true;

        "discord.detailsEditing" = "Editing {file_name} - on '{git_branch}'";
      };
      extensions =
        with pkgs.vscode-extensions;
        [
          catppuccin.catppuccin-vsc
          eamodio.gitlens
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "catppuccin-perfect-icons";
            publisher = "thang-nm";
            version = "0.21.33";
            sha256 = "sha256-nUf6jxkxn78Ha/uhL18JRJg0KdDNFGafBPioBn4OS6o=";
          }
          {
            name = "discord-vscode";
            publisher = "icrawl";
            version = "5.9.2";
            sha256 = "sha256-43ZAwaApQBqNzq25Uy/AmkQqprU7QlgJVVimfCaiu9k=";
          }
        ];
    };
  };

  programs.direnv.enable = true;
}
