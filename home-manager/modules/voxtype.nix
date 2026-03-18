{
  inputs,
  config,
  pkgs,
  ...
}: let
  voxtypeKey = "Scroll_Lock";
in {
  imports = [inputs.voxtype.homeManagerModules.default];

  programs.voxtype = {
    enable = true;
    package = inputs.voxtype.packages.${pkgs.system}.default;
    # large-v3 is the best multilingual Whisper model with strong German support
    model.name = "large-v3";
    service.enable = true;
    settings = {
      whisper = {
        language = "de";
        translate = false;
      };
    };
  };

  # Hyprland: push on press, release on key-up
  wayland.windowManager.hyprland.settings = {
    bind = [", ${voxtypeKey}, exec, voxtype push"];
    bindl = [", ${voxtypeKey}, exec, voxtype release"];
  };

  # Niri: only key-press events are supported for spawn actions
  programs.niri.settings.binds = {
    "${voxtypeKey}".action = config.lib.niri.actions.spawn "voxtype" "push";
  };
}
