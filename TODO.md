# hyprland.nix optimization TODOs

All items verified after re-login (2026-05-24):

- [x] **#2 hyprpolkitagent** — verified: running at PID 24701 via full store path (`/nix/store/.../libexec/hyprpolkitagent`); note: `pgrep hyprpolkitagent` misses it, use `pgrep -f polkit` instead
- [x] **#3 nm-applet** — verified: process running (PID confirmed)
- [x] **#4 walker** — verified: running as gapplication-service (PID 24707); Super+R opens walker
- [x] **#5 SUPER+SHIFT+arrows** — verified: all 4 directions registered (modmask 65 = SUPER+SHIFT)
- [x] **#6 Print screenshot** — verified: Print bind registered, grim and slurp both in PATH
- [x] **#7 misc/resize_on_border** — verified: `resize_on_border=true`, `disable_hyprland_logo=true`, `disable_splash_rendering=true` all confirmed via hyprctl
- [x] **#8 Wayland env vars** — verified: XCURSOR_SIZE=24, QT_QPA_PLATFORM=wayland, GDK_BACKEND=wayland, MOZ_ENABLE_WAYLAND=1 all set
