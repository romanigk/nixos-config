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
    ./hyprland.nix
  ];
}
