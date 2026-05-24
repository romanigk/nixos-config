# hyprland.nix optimization TODOs

Working through these step by step. Test after each change before continuing.

## In progress

- [ ] **#2 Add hyprpolkitagent to autostart** — committed, needs Hyprland restart to verify polkit dialogs appear (sudo prompts, 1Password unlock)

## Pending

- [ ] **#3 Add nm-applet to autostart** — `networkmanagerapplet` is installed but never launched; add `nm-applet` to the `hyprland.start` block so the network tray icon appears in waybar

- [ ] **#4 Resolve launcher inconsistency: wofi vs walker** — `walker` is installed but `SUPER+R` launches `wofi`. Either switch the bind to `walker` or drop `walker` from packages

- [ ] **#5 Add SUPER+SHIFT+arrows window movement keybindings** — currently `SUPER+arrows` only focuses; add `SUPER+SHIFT+arrows` using `hl.dsp.window.move({ direction = ... })`

- [ ] **#6 Add screenshot keybinding with grim+slurp** — add `grim` and `slurp` to `home.packages`, bind `Print` to `grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%s).png`

- [ ] **#7 Add resize_on_border and misc config block** — add `resize_on_border = true` to `general {}` and a `misc {}` block with `disable_hyprland_logo = true` and `disable_splash_rendering = true`

- [ ] **#8 Add Wayland environment variables** — add `hl.env()` calls for `XCURSOR_SIZE=24`, `QT_QPA_PLATFORM=wayland`, `GDK_BACKEND=wayland`, `MOZ_ENABLE_WAYLAND=1`
