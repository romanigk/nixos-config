{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./default.nix
  ];

  # This configuration is for thinkpad25 which uses GNOME
  # No Hyprland configuration needed here
}
