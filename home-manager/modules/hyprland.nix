{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    configType = "lua";
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    xwayland.enable = true;

    extraConfig = ''
      hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1080",
        position = "0x0",
        scale    = 1,
      })

      hl.config({
        input = {
          kb_layout    = "us,de",
          kb_variant   = "intl,",
          kb_options   = "grp:win_space_toggle",
          follow_mouse = 1,
          sensitivity  = 0,
          touchpad     = { natural_scroll = false },
        },
      })

      hl.config({
        general = {
          gaps_in     = 5,
          gaps_out    = 20,
          border_size = 2,
          col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
          },
          layout = "dwindle",
        },
      })

      hl.config({
        decoration = {
          rounding = 10,
          blur     = { enabled = true, size = 3, passes = 1 },
        },
      })

      hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
      hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
      hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
      hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
      hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
      hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
      hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

      hl.config({
        dwindle = { preserve_split = true },
      })

      hl.device({ name = "internal-german-laptop-keyboard", kb_layout = "de,us", kb_variant = ",intl",  kb_options = "grp:win_space_toggle" })
      hl.device({ name = "external-keyboard-us-layout",     kb_layout = "us,de", kb_variant = "intl,",  kb_options = "grp:alt_shift_toggle" })

      -- Keybindings
      local mod = "SUPER"

      hl.bind(mod .. " + Y", hl.dsp.exec_cmd("voxtype"))
      hl.bind(mod .. " + Q", hl.dsp.exec_cmd("kitty"))
      hl.bind(mod .. " + C", hl.dsp.window.close())
      hl.bind(mod .. " + M", hl.dsp.exit())
      hl.bind(mod .. " + E", hl.dsp.exec_cmd("nautilus"))
      hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mod .. " + R", hl.dsp.exec_cmd("wofi --show drun"))
      hl.bind(mod .. " + P", hl.dsp.window.pseudo())
      hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

      hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
      hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
      hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
      hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

      for i = 1, 9 do
        hl.bind(mod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
        hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
      end
      hl.bind(mod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
      hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

      hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
      hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

      hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

      -- Volume (locked + repeating)
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

      -- Brightness (repeating)
      hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

      -- Mouse window management
      hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Autostart
      hl.on("hyprland.start", function()
        hl.exec_cmd("blueman-applet")
        hl.exec_cmd("dunst")
        hl.exec_cmd("hyprpaper")
        hl.exec_cmd("waybar")
        hl.exec_cmd("[workspace 1 silent] idea")
        hl.exec_cmd("[workspace 2 silent] kitty")
        hl.exec_cmd("[workspace 3 silent] firefox")
        hl.exec_cmd("[workspace 4 silent] 1password")
      end)
    '';
  };

  home.packages = with pkgs; [
    dunst
    hyprpaper
    hyprpolkitagent
    kitty
    nautilus
    networkmanagerapplet
    pavucontrol
    walker
    waybar
    wofi
    yazi
  ];

  programs.waybar = {
    enable = true;
  };
}
