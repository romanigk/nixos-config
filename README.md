# NixOS und Home‑Manager Konfiguration

## Repository-Struktur

Diese NixOS-Konfiguration ist wie folgt strukturiert:

- `flake.nix`: Haupteinstiegspunkt; definiert Inputs und Outputs
- `hosts/`: NixOS‑spezifische Konfigurationen
  - `common/`: Gemeinsame Basiskonfiguration
  - `pulse15-gen1/`: Konfiguration für Tuxedo Pulse 15 Gen1
  - `thinkpad25/`: Konfiguration für ThinkPad 25
- `home-manager/`: Home‑Manager Konfigurationen
  - `default.nix`: Hauptkonfiguration für Home‑Manager
  - `pulse15-gen1.nix`: Host‑spezifische HM‑Konfiguration (Hyprland)
  - `thinkpad25.nix`: Host‑spezifische HM‑Konfiguration (GNOME)
  - `firefox.nix`: Firefox‑spezifische Einstellungen
- `modules/`: Wiederverwendbare Module (NixOS und Home‑Manager)
- `overlays/`: Paket‑Overlays
- `pkgs/`: Eigene Paketdefinitionen

## Verwendung

### System-Konfiguration aktualisieren

```bash
sudo nixos-rebuild switch --flake .#hostname
```

Wobei `hostname` entweder `pulse15-gen1` oder `thinkpad25` ist.

### Home-Manager-Konfiguration aktualisieren

```bash
home-manager switch --flake .#p1ng0ut@hostname
```

Wobei `hostname` entweder `pulse15-gen1` oder `thinkpad25` ist.

### Flake aktualisieren

```bash
nix flake update
```

### Formatierung und Checks

- Code formatieren (nutzt den im Flake hinterlegten Formatter `alejandra`):

  ```bash
  nix fmt
  ```

- Flake prüfen (empfohlen vor Änderungen/Rebuilds):

  ```bash
  nix flake check
  ```

## Konfigurationsumfang

## Hauptfunktionen

- Desktop‑Umgebungen: GNOME (thinkpad25), Hyprland (pulse15-gen1)
- Fish als Standard‑Shell
- Neovim als Standard‑Editor
- Firefox mit datenschutzorientierten Einstellungen
- 1Password‑Integration
- Docker (rootless)
- Entwicklungstools und Anwendungen

## Tastaturlayout wechseln

Unterstützung für US‑ und DE‑Tastaturlayouts mit umschaltbarem Layout.

Layouts umschalten: Super + Leertaste. Verfügbare Layouts:
- US English Layout (QWERTY)
- Deutsches Layout (QWERTZ mit ä, ö, ü, ß)

Konfiguration:
- GNOME (thinkpad25): `/hosts/common/default.nix`
- Hyprland (pulse15-gen1): `/modules/home-manager/hyprland.nix`
- Konsole (TTY): Standard `console.keyMap = "de"`

### Hyprland Hinweise

- Das Layout‑Toggle (Super+Leertaste) ist in Hyprland ebenfalls konfiguriert (`kb_options = "grp:win_space_toggle"`).
- Geräte‑spezifische Keymaps: In `modules/home-manager/hyprland.nix` gibt es Beispiel‑Einträge unter `device = [ ... ]`.
  Diese benötigen die exakten Gerätenamen der Tastaturen. Ermittlung mit:

  ```bash
  hyprctl devices | grep -E "(Keyboard|name)"
  ```

  Anschließend die genauen Namen in den `device`‑Blöcken eintragen oder die Beispiel‑Einträge entfernen.

---

## English Summary

- NixOS + Home‑Manager setup for hosts `pulse15-gen1` and `thinkpad25`.
- Rebuild system: `sudo nixos-rebuild switch --flake .#<hostname>`.
- Apply Home‑Manager: `home-manager switch --flake .#p1ng0ut@<hostname>`.
- Update inputs: `nix flake update`; check flake: `nix flake check`; format code: `nix fmt` (Alejandra).
