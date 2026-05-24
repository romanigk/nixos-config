# hyprland.nix optimization TODOs

All items verified or fixed. Restart Hyprland to confirm #2 and #4:

- [ ] **#2 hyprpolkitagent** — fixed: binary lives in `libexec` (not in PATH), now using full Nix store path in autostart; restart to verify polkit dialogs appear
- [x] **#3 nm-applet** — verified: process running (PID confirmed)
- [ ] **#4 walker** — fixed: `elephant` data provider added as package + autostart before walker; restart to verify Super+R opens walker
- [x] **#5 SUPER+SHIFT+arrows** — verified: all 4 directions registered (modmask 65 = SUPER+SHIFT)
- [x] **#6 Print screenshot** — verified: Print bind registered, grim and slurp both in PATH
- [x] **#7 misc/resize_on_border** — verified: `resize_on_border=true`, `disable_hyprland_logo=true`, `disable_splash_rendering=true` all confirmed via hyprctl
- [x] **#8 Wayland env vars** — verified: XCURSOR_SIZE=24, QT_QPA_PLATFORM=wayland, GDK_BACKEND=wayland, MOZ_ENABLE_WAYLAND=1 all set
