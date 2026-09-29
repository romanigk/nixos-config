{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./default.nix
    ./modules/hyprland.nix
    ./modules/niri.nix
  ];
}
