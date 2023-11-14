# Meine erste NixOS Konfiguration
## Vorgeschichte

Um NixOS auf einem PC zu nutzen, und die Konfiguration dafür versioniert in einer Versionsverwaltung abzulegen, ist ein wenig Vorwissen notwendig. Doch warum sollte jemand das überhaupt wollen? NixOS hat den Vorteil, dass die einzigen wesentlichen Konfigurationsdateien unter `/etc/nixos` liegen und `configuration.nix` sowie `hardware-configuration.nix` heißen. Jede Veränderung an diesen Dateien, oder den Versionen installierter Software, erzeugt eine neue Generation von nixOS. So kann man einfach auf vorhergehende Versionen der Systemkonfiguration zurück springen, sollte etwas mal nicht funktionieren. Die Herausforderung beim Einsatz einer Versionsverwaltung wie `git` ist, dass `/etc/nixos` ein Verzeichnis ist, das dem Superuser `root` gehört. Dort will man erfahrungsgemäß keine Versionsverwaltungssoftware benutzen, die dann für jede Operation die Rechte des Superusers auf dem System benötigen würde.

Die einfachste Lösung ist die Konfiguration an einen Ort im eigenen `home`-Verzeichnis zu kopieren, dort mit `git` die verschiedenen versionen zu verwalten und das Ergebnis aus dem main branch wieder in `/etc/nixos` zu verlinken, unter zuhilfenahme des Konsolenprogramms `ln`. Damit wäre ein hoher manueller Aufwand verbunden. Zwangsläufig denkt man, muss das so kompliziert sein? Gibt es da nichts aus der nixOS-Community?

Fragt man Menschen, die nixOS schon etwas länger nutzen und sich ein bisschen besser auskennen, heißt es schnell: Schau Dir mal [Home-Manager](https://nix-community.github.io/home-manager/ "Das Benutzerhandbuch von Home-Manager auf Englisch") oder [Flakes](https://nix.dev/concepts/flakes.html "Das Konzept hinter flakes auf Englisch") an. Doch was sind das denn für Programme und wozu soll ich mich damit beschäftigen?

## Home Manager

Home-Manager ist ein System, um eine Nutzerumgebung mit Nix zu managen. Es erlaubt die deklarative Installation von Software, anstatt ein Nix Environment `nix-env` zu verwenden. Man braucht kein zusätzliches System mehr, um seine sogenannten Dotfiles zu versionieren und wiederzuverwenden. Es erlaubt auch die Konfiguration in einer Versionsverwaltung abzulegen.

## Flakes

[...]
