{
  config,
  pkgs,
  zen-browser,
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

      gcovr
      criterion
      valgrind
      gnumake42
    ]
  );

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        wrapProgram $out/bin/code --add-flags "--no-sandbox"
      '';
    });
    profiles.default = {
      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
        "workbench.secondarySidebar.defaultVisibility" = "hidden";
        "workbench.layoutControl.enabled" = false;
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Catppuccin Mocha";

        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;

        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = 0.5;

        "github.copilot.enable" = {
          "*" = false;
        };
        "chat.commandCenter.enabled" = false;
        "workbench.commandPalette.experimental.suggestCommands" = false;
        "editor.inlineSuggest.enabled" = false;
        "chat.experimental.detectParticipant.enabled" = false;

        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
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
