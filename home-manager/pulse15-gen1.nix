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
    ./hyprland.nix
  ];
}
