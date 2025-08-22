{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./home.nix
  ];

  # This configuration is for thinkpad25 which uses GNOME
  # No Hyprland configuration needed here
}
