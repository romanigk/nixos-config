# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Claude Code Instructions

When you make changes to the home-manager configuration (any files in `home-manager/` or related nix files that affect home-manager), you MUST:

1. Commit the changes to git with an appropriate commit message
2. Run `home-manager switch --flake .` to apply the configuration

Do not skip these steps. The user expects changes to be committed and applied automatically.

## Repository Overview

This is a NixOS and Home Manager flake-based configuration for two hosts: `pulse15-gen1` (Tuxedo Pulse 15 with Hyprland/Niri) and `thinkpad25` (ThinkPad 25 with GNOME). The configuration uses a modular structure with shared common settings and host-specific customizations.

## Workflow

**Important**: All configuration changes must be committed to git before they can be applied.

### Home Manager Changes

1. Make changes to the configuration
2. Commit changes to git with an appropriate message
3. Apply the configuration:
   ```bash
   home-manager switch --flake .#p1ng0ut@pulse15-gen1
   # or
   home-manager switch --flake .#p1ng0ut@thinkpad25
   ```

### NixOS Changes

1. Make changes to the configuration
2. Commit changes to git with an appropriate message
3. Apply the configuration with admin permissions:
   ```bash
   sudo nixos-rebuild switch --flake .#pulse15-gen1
   # or
   sudo nixos-rebuild switch --flake .#thinkpad25
   ```

## Essential Commands

```bash
# Update flake inputs
nix flake update

# Format code (uses alejandra formatter)
nix fmt

# Check flake validity
nix flake check

# Build custom packages defined in pkgs/
nix build .#<package-name>
```

## Architecture

### Flake Structure

The `flake.nix` is the entry point and defines:
- **Inputs**: nixpkgs (unstable), nixpkgs-stable (25.05), systems, home-manager, hyprland, niri, nixos-hardware, nix-jetbrains-plugins
- **Outputs**: Two NixOS configurations and two Home Manager configurations
- **Special Args**: `inputs` and `outputs` are passed to all modules via `specialArgs`/`extraSpecialArgs`

### Module System

The configuration uses a hierarchical module structure:

1. **NixOS Modules** (`modules/nixos/`): Currently empty placeholder for reusable system modules
2. **Home Manager Modules** (`home-manager/modules/`): Contains email.nix, firefox.nix, git.nix, hyprland.nix, niri.nix, packages.nix, shell.nix
3. **Overlays** (`overlays/default.nix`): Defines `additions` (custom packages) and `modifications` (package overrides)
4. **Custom Packages** (`pkgs/default.nix`): Placeholder for custom package definitions

### Host Configuration Pattern

Each host follows this import pattern:

```
hosts/<hostname>/
  ├── default.nix          # Host-specific config
  └── hardware-configuration.nix
```

Host configs import `../common` which provides shared base configuration including:
- System settings (locale, timezone, keyboard)
- Common services (pipewire, bluetooth, NetworkManager)
- Base packages (git, neovim, tmux)
- User definition for p1ng0ut
- 1Password integration
- Docker rootless setup
- Direnv (system-wide)

### Home Manager Configuration Pattern

Home Manager configs are in `home-manager/`:
- `default.nix`: Base configuration shared by all hosts (imports modules, 1Password SSH integration)
- `pulse15-gen1.nix`: Imports default.nix + hyprland.nix + niri.nix
- `thinkpad25.nix`: Imports only default.nix (GNOME-based)

Modules in `home-manager/modules/`:
- `packages.nix`: Package categories (communication, devTools, email, fonts, multimedia, officeTools, systemUtils)
- `email.nix`: Email account configuration (mailbox.org with 1Password integration)
- `git.nix`: Git configuration
- `shell.nix`: Fish shell configuration
- `firefox.nix`: Firefox browser configuration
- `hyprland.nix`: Hyprland compositor configuration
- `niri.nix`: Niri compositor configuration

### Desktop Environment Setup

- **pulse15-gen1**: Uses SDDM + Hyprland/Niri (Wayland compositors)
- **thinkpad25**: Uses GDM + GNOME

Both hosts support US/DE keyboard layout switching with Super+Space.

### Overlay and Package Extension Points

To add custom packages:
1. Define in `pkgs/<package-name>/default.nix`
2. Export in `pkgs/default.nix`
3. They become available via the `additions` overlay

To modify existing packages:
1. Add overrides to `overlays/default.nix` in the `modifications` section

### Key Configuration Locations

- **Keyboard layouts**:
  - NixOS (console): `hosts/common/default.nix` (console.keyMap)
  - Hyprland: `home-manager/modules/hyprland.nix`
- **User packages**: `home-manager/modules/packages.nix` (categorized lists)
- **System packages**: `hosts/common/default.nix`
- **1Password SSH integration**: `home-manager/default.nix` (agent.toml + SSH config)
- **Email configuration**: `home-manager/modules/email.nix`

## Important Notes

- The configuration uses `nixos-unstable` as the primary nixpkgs input
- Flakes are enabled; legacy nix-channel is disabled
- Automatic garbage collection runs weekly (deletes >30 days)
- Store optimization is enabled automatically
- allowUnfree is enabled for both NixOS and Home Manager
- User p1ng0ut uses Fish shell by default with direnv integration
- Neovim is the default editor system-wide
