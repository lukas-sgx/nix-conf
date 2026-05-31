{ config, pkgs, zen-browser, system, lib, inputs, ... }:

let
    env = import ./env.nix;
in  
{
    home.username = env.username;
    home.homeDirectory = env.homeDir;
    home.stateVersion = env.nixVersion;

    home.packages = (with pkgs; [
        vscode
        zed-editor
        discord
        devenv
        go
        gh
        qemu
	      openvpn

        kind
        kubectl

        rustup

        gnome-extension-manager
        tmux 
        eza
        fzf
        zoxide
        cargo-watch
        microfetch
    ]) ++ [
        zen-browser.packages.${system}.default
    ];

    programs.git = {
        enable = true;
        settings = {
            user.name = env.gitUser;
            user.email = env.gitUser;
            user.signingkey = "19F45BF088FD1431";
            init.defaultBranch = "main";
            pull.rebase = false;
            commit.gpgsign = true;
            tag.gpgSign = true;
        };
    };

    programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        profiles.default.userSettings = {
            "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
            "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace";
            
        };
    };

    programs.fish = {
        enable = true;
        shellAliases = {
            ll     = "eza -la --icons --git --group-directories-first";
            lt     = "eza --tree --icons --level=2";
            ls     = "eza --icons";
            nrs    = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
            nfu    = "sudo nix flake update --flake /etc/nixos";
            nfu-switch = "nfu && nrs";
            g = "git";
            kb     = "kubectl";
            ki     = "kind";
            ".."   = "cd ..";
            "..."  = "cd ../..";
        };

        plugins = [
            { name = "tide";     src = pkgs.fishPlugins.tide.src; }
            { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
        ];

        interactiveShellInit = ''
            set -g fish_greeting ""
            zoxide init fish | source
            fish_add_path --path $HOME/.local/bin

            # Catppuccin Mocha — syntax fish
            set -g fish_color_normal          cdd6f4
            set -g fish_color_command         89b4fa
            set -g fish_color_keyword         cba6f7
            set -g fish_color_quote           a6e3a1
            set -g fish_color_redirection     f5c2e7
            set -g fish_color_end             fab387
            set -g fish_color_error           f38ba8
            set -g fish_color_param           cdd6f4
            set -g fish_color_comment         6c7086
            set -g fish_color_autosuggestion  6c7086
            set -g fish_color_operator        f5c2e7
            set -g fish_color_escape          f2cdcd
            set -g fish_pager_color_progress  cba6f7

            # Tide — Layout
            set -U tide_left_prompt_items  os pwd git newline character
            set -U tide_right_prompt_items cmd_duration time
            set -U tide_prompt_add_newline_before false
            set -U tide_prompt_min_cols 34

            # Tide — OS
            set -U tide_os_bg_color           cba6f7
            set -U tide_os_color              1e1e2e
            set -U tide_os_icon               '󱄅'

            # Tide — PWD
            set -U tide_pwd_bg_color          89b4fa
            set -U tide_pwd_bg_color_anchors  89b4fa
            set -U tide_pwd_color_anchors     1e1e2e
            set -U tide_pwd_color_dirs        1e1e2e
            set -U tide_pwd_color_truncated_dirs 313244
            set -U tide_pwd_icon              '󰉋'
            set -U tide_pwd_icon_home         '󱂵'

            # Tide — Git clean
            set -U tide_git_bg_color          a6e3a1
            set -U tide_git_color_branch      1e1e2e
            set -U tide_git_color_clean       1e1e2e
            set -U tide_git_icon              '󰊢'

            # Tide — Git dirty
            set -U tide_git_bg_color_unstaged f9e2af
            set -U tide_git_color_dirty       1e1e2e
            set -U tide_git_color_staged      1e1e2e
            set -U tide_git_color_untracked   1e1e2e
            set -U tide_git_color_ahead       1e1e2e
            set -U tide_git_color_behind      1e1e2e
            set -U tide_git_color_conflicted  f38ba8

            # Tide — Durée commandes
            set -U tide_cmd_duration_bg_color 313244
            set -U tide_cmd_duration_color    fab387
            set -U tide_cmd_duration_icon     '󱦟'
            set -U tide_cmd_duration_threshold 0
            set -U tide_cmd_duration_decimals 2

            # Tide — Heure
            set -U tide_time_bg_color         313244
            set -U tide_time_color            6c7086
            set -U tide_time_icon             '󰥔'

            # Tide — Status
            set -U tide_status_icon           '󰄬'
            set -U tide_status_icon_failure   '󰅚'

            # Tide — Outils
            set -U tide_go_icon               '󰟓'
            set -U tide_go_bg_color           94e2d5
            set -U tide_go_color              1e1e2e
            set -U tide_kubectl_icon          '󱃾'
            set -U tide_kubectl_bg_color      cba6f7
            set -U tide_kubectl_color         1e1e2e
            set -U tide_node_icon             '󰎙'
            set -U tide_python_icon           '󰌠'
            set -U tide_docker_icon           '󰡨'
            set -U tide_nix_shell_icon        '󱄅'
            set -U tide_nix_shell_bg_color    89b4fa
            set -U tide_nix_shell_color       1e1e2e
            set -U tide_jobs_icon             '󰑮'

            # Tide — Curseur
            set -U tide_prompt_color_success  a6e3a1
            set -U tide_prompt_color_failure  f38ba8
            set -U tide_character_icon        '❯'
            set -U tide_character_vi_icon_default '❯'
            set -U tide_prompt_icon_connection ' '
            set -U tide_prompt_connection_enabled false

            # FZF
            set -gx FZF_DEFAULT_OPTS "--color=bg+:#313244,bg:#1e1e2e,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --border rounded --prompt '❯ '"
        
            set -gx LIBRARY_PATH $HOME/.nix-profile/lib $LIBRARY_PATH
            set -gx C_INCLUDE_PATH $HOME/.nix-profile/include $C_INCLUDE_PATH
            set -gx CPATH $HOME/.nix-profile/include $CPATH
            set -gx PKG_CONFIG_PATH $HOME/.nix-profile/lib/pkgconfig $PKG_CONFIG_PATH
            set -gx LD_LIBRARY_PATH $HOME/.nix-profile/lib $LD_LIBRARY_PATH

            if tty > /dev/null 2>&1
                set -x GPG_TTY (tty)
            end
            microfetch
        '';
    };

    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*".addKeysToAgent = "yes";
    };

    programs.home-manager.enable = true;

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
