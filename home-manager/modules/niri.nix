{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "us,de";
      variant = "intl,";
      options = "grp:win_space_toggle";
    };

    spawn-at-startup = [
      {command = ["waybar"];}
    ];

    binds = with config.lib.niri.actions; {
      # Help / Overview
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+O".action = toggle-overview;

      # Application launchers
      "Mod+Return".action = spawn "alacritty";
      "Mod+D".action = spawn "fuzzel";

      # Window management
      "Mod+Shift+Q".action = close-window;
      "Mod+Shift+E".action = quit;

      # Focus navigation
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;

      # Move windows
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+J".action = move-window-down;
      "Mod+Shift+K".action = move-window-up;

      # Workspace navigation
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      # Column management
      "Mod+Comma".action = consume-or-expel-window-left;
      "Mod+Period".action = consume-or-expel-window-right;

      # Floating windows
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      # Layout controls
      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      # Scrolling
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;

      # Screen lock
      "Mod+Escape".action = spawn "swaylock";
    };

    layout = {
      gaps = 16;
      center-focused-column = "never";
      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];
      default-column-width = {proportion = 1.0 / 2.0;};
      focus-ring = {
        width = 2;
        active.color = "#33ccff";
        inactive.color = "#595959";
      };
    };
  };

  programs.waybar.enable = true;

  home.packages = with pkgs; [
    alacritty
    fuzzel
    swaylock
  ];
}
