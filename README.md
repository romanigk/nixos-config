# Meine NixOS Konfiguration

Seit einiger Zeit beschäftige ich mich sporadisch mit NixOS und ich habe bereits gelernt, dass man sich mit [Flakes](https://nixos.wiki/wiki/Flakes) oder der [Home-Manager](https://nixos.wiki/wiki/Home_Manager) auseinander setzen sollte, um seine Konfiguration ordentlich in einer Versionsverwaltung pflegen zu können. Um beim Konfigurieren nicht bei null anzufangen, sind ein paar Tipps von erfahrenen Nix(OS)-Nutzern sehr nützlich, aber auch ein Generator für die [Starter-Konfiguration](https://github.com/Misterio77/nix-starter-configs), wie bspw. der von Misterio77.

## Repository-Struktur

Diese NixOS-Konfiguration ist wie folgt strukturiert:

- `flake.nix`: Haupteinstiegspunkt der Konfiguration, definiert Inputs und Outputs
- `nixos/`: NixOS-spezifische Konfigurationen
  - `common/`: Gemeinsame Konfiguration für alle Systeme
  - `pulse15-gen1/`: Spezifische Konfiguration für den Tuxedo Pulse 15 Gen1 Laptop
  - `thinkpad25/`: Spezifische Konfiguration für den ThinkPad 25 Laptop
- `home-manager/`: Home-Manager-Konfigurationen für den Benutzer
  - `home.nix`: Hauptkonfiguration für Home-Manager
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

## Hauptfunktionen

- GNOME Desktop-Umgebung
- Fish als Standard-Shell
- Neovim als Standard-Editor
- Firefox mit Datenschutz-Fokus
- 1Password-Integration
- Docker (rootless)
- Verschiedene Entwicklungstools und Anwendungen
