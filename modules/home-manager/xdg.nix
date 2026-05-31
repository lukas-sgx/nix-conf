{ config, pkgs, zen-browser, system, lib, inputs, ... }:
{ 
  xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
  };

  xdg.desktopEntries."dev.zed.Zed" = {
      name = "Zed";
      genericName = "Text Editor";
      comment = "A high-performance, multiplayer code editor.";
      exec = "zeditor %U";
      icon = "/home/lukas/.local/share/icons/zed.png";
      categories = [ "Utility" "TextEditor" "Development" "IDE" ];
      mimeType = [ "text/plain" "application/x-zerosize" "x-scheme-handler/zed" ];
      startupNotify = true;
      actions = {
          "NewWorkspace" = {
              exec = "zeditor --new %U";
              name = "Open a new workspace";
          };
      };
  };
  xdg.desktopEntries."org.gnome.Console" = {
      name = "Console";
      exec = "kgx";
      icon = "/home/lukas/.local/share/icons/gnome-terminal-custom.png";
      categories = [ "System" "TerminalEmulator" ];
  };
  xdg.desktopEntries."org.gnome.Nautilus" = {
      name = "Files";
      exec = "nautilus --new-window %U";
      icon = "/home/lukas/.local/share/icons/claude.png";
      categories = [ "System" "FileManager" ];
      mimeType = [ "inode/directory" ];
  };
}