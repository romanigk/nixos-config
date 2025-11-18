# Meine NixOS Konfiguration

Seit einiger Zeit beschäftige ich mich sporadisch mit NixOS und ich habe bereits gelernt, dass man sich mit [Flakes](https://nixos.wiki/wiki/Flakes) oder der [Home-Manager](https://nixos.wiki/wiki/Home_Manager) auseinander setzen sollte, um seine Konfiguration ordentlich in einer Versionsverwaltung pflegen zu können. Um beim Konfigurieren nicht bei null anzufangen, sind ein paar Tipps von erfahrenen Nix(OS)-Nutzern sehr nützlich, aber auch ein Generator für die [Starter-Konfiguration](https://github.com/Misterio77/nix-starter-configs), wie bspw. der von Misterio77.

## Repository-Struktur

Diese NixOS-Konfiguration ist wie folgt strukturiert:

- `flake.nix`: Haupteinstiegspunkt der Konfiguration, definiert Inputs und Outputs
- `hosts/`: NixOS-spezifische Konfigurationen
  - `common/`: Gemeinsame Konfiguration für alle Systeme
  - `pulse15-gen1/`: Spezifische Konfiguration für den Tuxedo Pulse 15 Gen1 Laptop
  - `thinkpad25/`: Spezifische Konfiguration für den ThinkPad 25 Laptop
- `home-manager/`: Home-Manager-Konfigurationen für den Benutzer
  - `default.nix`: Hauptkonfiguration für Home-Manager
  - `pulse15-gen1.nix`: Host-spezifische HM-Konfiguration (Hyprland)
  - `thinkpad25.nix`: Host-spezifische HM-Konfiguration (GNOME)
  - `firefox.nix`: Firefox-spezifische Konfiguration
- `modules/`: Wiederverwendbare Module für NixOS und Home-Manager
- `overlays/`: Anpassungen und Erweiterungen für Pakete
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

## Entwicklungsrichtlinien

- Commit-Nachrichten sollten auf Englisch verfasst werden
- Versuche, aussagekräftige Commit-Nachrichten zu schreiben, die die Änderungen klar beschreiben

Hinweis: Dieses README ist überwiegend auf Deutsch verfasst, Commit‑Nachrichten jedoch auf Englisch.

## Hauptfunktionen

- Desktop-Umgebung: GNOME (thinkpad25), Hyprland (pulse15-gen1)
- Fish als Standard-Shell
- Neovim als Standard-Editor
- Firefox mit Datenschutz-Fokus
- 1Password-Integration
- Docker (rootless)
- Verschiedene Entwicklungstools und Anwendungen

## Tastaturlayout wechseln

Diese Konfiguration unterstützt sowohl US- als auch Deutsche (DE) Tastaturlayouts mit einfachem Wechsel zwischen ihnen.

**Layouts wechseln:** Drücke **Tux + Leertaste** (Super-Taste + Leertaste) um zwischen folgenden Layouts zu wechseln:
- US English Layout (QWERTY)
- Deutsches Layout (QWERTZ mit ä, ö, ü, ß)

**Konfiguration:**
- GNOME Desktop (thinkpad25): Konfiguriert in `/hosts/common/default.nix`
- Hyprland (pulse15-gen1): Konfiguriert in `/modules/home-manager/hyprland.nix`
- Konsole (TTY): Verwendet standardmäßig deutsches Layout (`console.keyMap = "de"`)

### Hyprland Hinweise & Troubleshooting

- Das Layout‑Toggle (Super+Leertaste) ist in Hyprland ebenfalls konfiguriert (`kb_options = "grp:win_space_toggle"`).
- Geräte‑spezifische Keymaps: In `modules/home-manager/hyprland.nix` gibt es Beispiel‑Einträge unter `device = [ ... ]`.
  Diese benötigen die exakten Gerätenamen deiner Tastaturen. Ermittele diese mit:

  ```bash
  hyprctl devices | grep -E "(Keyboard|name)"
  ```

  Trage anschließend die genauen Namen in den `device`‑Blöcken ein oder entferne die Beispiel‑Einträge, falls nicht benötigt.

---

## English TL;DR

- This repo contains my NixOS + Home‑Manager setup (German README, English commit messages).
- Rebuild system: `sudo nixos-rebuild switch --flake .#<hostname>` (hosts: `pulse15-gen1`, `thinkpad25`).
- Apply Home‑Manager: `home-manager switch --flake .#p1ng0ut@<hostname>`.
- Update inputs: `nix flake update`; check flake: `nix flake check`; format code: `nix fmt` (Alejandra).
