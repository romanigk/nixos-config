{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;

    settings = {
      monitor = "eDP-1,1920x1080,0x0,1";

      input = {
        kb_layout = "us,de";
        kb_variant = "intl,";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      device = [
        {
          # Internal laptop keyboard - example for ThinkPad
          name = "internal-german-laptop-keyboard";
          kb_layout = "de,us";
          kb_variant = ",intl";
          kb_options = "grp:win_space_toggle";
        }
        {
          # External keyboard - US layout
          name = "external-keyboard-us-layout";
          kb_layout = "us,de";
          kb_variant = "intl,";
          kb_options = "grp:alt_shift_toggle";
        }
      ];

      exec-once = [
        "blueman-applet"
        "dunst"
        "hyprpaper"
        "waybar"
        "[workspace 1 silent] 1password"
        "[workspace 2 silent] idea-ultimate"
        "[workspace 3 silent] firefox"
        "[workspace 4 silent] kitty"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, nautilus"
        "$mod, V, togglefloating,"
        "$mod, R, exec, wofi --show drun"
        "$mod, P, pseudo, # dwindle"
        "$mod, J, togglesplit, # dwindle"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
      ];
    };
  };

  home.packages = with pkgs; [
    dunst
    hyprpaper
    hyprpolkitagent
    kitty
    nautilus
    networkmanagerapplet
    walker
    waybar
    wofi
    yazi
  ];

  # Hinweis: Keine Überschreibung von LANG/LC_* hier, damit die Session
  # die systemweite Locale (de_DE.UTF-8) erbt. Falls nötig, kann man
  # gezielt nur LC_CTYPE temporär setzen, ohne LC_ALL zu verwenden.

  programs.waybar = {
    enable = true;
  };
}
