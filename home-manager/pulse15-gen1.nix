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
    ./modules/hyprland.nix
  ];
}
