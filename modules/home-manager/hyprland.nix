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

      exec-once = [
        "blueman-applet"
        "dunst"
        "hyprpaper"
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

  # Install fonts for the user (moved from system to Home Manager)
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-emoji
  ];

  # Einheitliche UTF-8-Umgebung für den User (behebt häufige Encoding-Probleme in Waybar)
  home.sessionVariables = {
    LANG = "C.UTF-8";
    LC_ALL = "C.UTF-8";
    LC_CTYPE = "C.UTF-8";
  };

  # Configure Waybar to use proper font fallbacks for icons + ein dezentes Theme
  programs.waybar = {
    enable = true;
    style = ''
      /* Farben (dezentes, neutrales Schema) */
      @define-color bg        #1e1e2e;
      @define-color bg-alt    #11111b;
      @define-color surface   #313244;
      @define-color text      #cdd6f4;
      @define-color subtext   #a6adc8;
      @define-color accent    #89b4fa;
      @define-color ok        #a6e3a1;
      @define-color warn      #f9e2af;
      @define-color crit      #f38ba8;

      * {
        font-family: "FiraCode Nerd Font", "DroidSansMono Nerd Font", "Symbols Nerd Font", "Symbols Nerd Font Mono", "Noto Color Emoji";
        font-size: 12pt;
        min-height: 0;
      }

      window#waybar {
        background: alpha(@bg, 0.85);
        color: @text;
        border: 1px solid alpha(@surface, 0.8);
        border-radius: 12px;
        padding: 4px 8px;
        margin: 6px 8px;
      }

      /* Allgemeine Modul-Optik */
      #workspaces,
      #tray,
      #clock,
      #battery,
      #network,
      #pulseaudio,
      #backlight,
      #bluetooth {
        background: alpha(@surface, 0.55);
        border-radius: 10px;
        padding: 2px 8px;
        margin: 0 4px;
      }

      /* Spezial-Font-Fallback für symbol-lastige Module */
      #workspaces button,
      #battery,
      #network,
      #pulseaudio,
      #backlight,
      #clock,
      #bluetooth,
      #tray {
        font-family: "Symbols Nerd Font", "Symbols Nerd Font Mono", "FiraCode Nerd Font", "DroidSansMono Nerd Font", "Noto Color Emoji";
      }

      /* Workspaces */
      #workspaces {
        padding: 2px 4px;
      }
      #workspaces button {
        color: @subtext;
        padding: 0 8px;
        margin: 0 2px;
        border-radius: 8px;
        background: transparent;
      }
      #workspaces button.active {
        color: @text;
        background: alpha(@accent, 0.18);
      }
      #workspaces button:hover {
        background: alpha(@accent, 0.28);
        color: @text;
      }

      /* Statusfarben */
      #battery.charging,
      #battery.plugged {
        color: @ok;
      }
      #battery.warning:not(.charging) {
        color: @warn;
      }
      #battery.critical:not(.charging) {
        color: @crit;
      }

      #network.disconnected {
        color: @warn;
      }

      #pulseaudio.muted {
        color: @subtext;
      }

      /* Tray */
      #tray > .passive {
        opacity: 0.6;
      }
      #tray > .needs-attention {
        color: @warn;
      }

      /* Uhr etwas hervorheben */
      #clock {
        background: alpha(@accent, 0.16);
        color: @text;
      }
    '';
  };
}
