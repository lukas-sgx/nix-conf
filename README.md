# NixOS & Home Manager Configuration ❄️

This repository contains my personal and declarative configuration for NixOS, built around **Flakes** and **Home Manager**. It's designed for my daily use with a GNOME desktop environment, a development setup (especially for Epitech projects), and workflow optimizations using the Fish shell.

## 🚀 Key Features

- **Global File Management via Flakes:** Ensured reproducibility through `flake.nix`.
- **Desktop Environment:** Centralized GNOME via GDM with a few useful extensions.
- **Shell & Terminal:** **Fish** shell configured with the Tide theme via `setup.sh`.
- **Impermanence:** System state persistence management using the `nix-community/impermanence` module.
- **Development & Epitech:** 
  - C/C++ Toolchain: `clang`, `llvm 20`, `gcovr`, `criterion`, `valgrind`, `gnumake42` (ideal for Epitech coding styles and tests).
  - Integrated Tools: Docker, Go, Rustup, Kubernetes (Kind, Kubectl), Direnv, Devenv, etc.
  - Editors: VSCode (pre-configured with JetBrainsMono Nerd Font) and Zed.
  - Deployment: Exegol (cybersecurity/dev tools installable via `setup.sh`).
- **Additional Software:** Integration of the [Zen Browser](https://github.com/zen-browser/desktop) directly from its flake.
- **Hardware Support:** Configuration for boot, Bluetooth, audio, fingerprint reader, and power management (thermald).

## 📂 Project Structure

```text
.
├── flake.nix                  # Entry point of the configuration
├── config.nix                 # Global NixOS configuration (system, accounts, boot...)
├── env.nix                    # User environment variables (name, git, keys...)
├── home.nix                   # Entry point for Home Manager
├── setup.sh                   # Post-installation setup script (Fish Tide, Exegol...)
└── modules/
    ├── home-manager/          # User space configuration modules
    │   ├── development.nix    # Development tools and environments
    │   ├── epiclang.nix       # Specific configurations (C/C++, GCC, Clang...)
    │   ├── fish.nix           # Shell configuration
    │   ├── git.nix            # Git settings
    │   ├── ssh.nix            # OpenSSH client configuration
    │   └── xdg.nix            # User database settings
    └── ...                    # System modules (audio, gnome, network, gpg, boot...)
```

## ⚙️ Environment Variables (`env.nix`)

All personal information is gathered in `env.nix`, such as the username, GPG keys, Git email, etc. This file is used by different parts of the code (nixosModules & homeManager) to avoid redundancy. Make sure to adapt these credentials for your own needs when reusing the project.

## 🛠️ Installation & Updates

### Apply System Configuration

To apply the configuration directly to your system:
```bash
sudo nixos-rebuild switch --flake .#nixos
```
Alternatively, use `nh` (a useful helper tool installed on the system) for a clean build or build profile management:
```bash
nh os switch .
```

### Post-Installation Setup

Once the system is updated, remember to run the setup script to configure the **Fish** shell theme (Tide) and additional virtual environments:
```bash
./setup.sh
```

## ✨ Cache and Store Management

The configuration includes various cleanup tasks (Garbage Collection configured weekly) and enables automatic optimization of the nix-store. Experimental NixOS features are enabled by default (`nix-command` and `flakes`).
