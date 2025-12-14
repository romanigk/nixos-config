{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
    package = inputs.niri.packages."${pkgs.stdenv.hostPlatform.system}".niri-stable;

    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us,de";
            variant = "intl,";
            options = "grp:win_space_toggle";
          };
        };

        touchpad = {
          tap = true;
          natural-scroll = false;
        };
      };

      outputs = {
        "eDP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
        };
      };

      layout = {
        gaps = 16;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        default-column-width = { proportion = 0.5; };
        focus-ring = {
          enable = true;
          width = 2;
          active-color = "#33ccff";
          inactive-color = "#595959";
        };
        border = {
          enable = true;
          width = 2;
          active-color = "#33ccff";
          inactive-color = "#595959";
        };
      };

      prefer-no-csd = true;

      spawn-at-startup = [
        { command = ["blueman-applet"]; }
        { command = ["dunst"]; }
        { command = ["waybar"]; }
        { command = ["1password"]; }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Q".action.spawn = ["kitty"];
        "Mod+C".action = close-window;
        "Mod+Shift+E".action = quit;
        "Mod+E".action.spawn = ["nautilus"];
        "Mod+V".action = toggle-floating;
        "Mod+R".action.spawn = ["wofi" "--show" "drun"];
        "Mod+F".action = fullscreen-window;

        # Focus movement
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-up;
        "Mod+Down".action = focus-window-down;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+K".action = focus-window-up;
        "Mod+J".action = focus-window-down;

        # Move windows
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+J".action = move-window-down;

        # Workspaces
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        # Move to workspace
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;

        # Column resizing
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        # Screenshots
        "Print".action.spawn = ["grim" "-g" "$(slurp)" "-" "|" "wl-copy"];
      };
    };
  };

  home.packages = with pkgs; [
    dunst
    grim
    kitty
    nautilus
    networkmanagerapplet
    slurp
    walker
    waybar
    wl-clipboard
    wofi
    yazi
  ];

  programs.waybar = {
    enable = true;
  };
}
