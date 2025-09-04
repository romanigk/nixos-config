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
    ../modules/home-manager/hyprland.nix
  ];
  
  home.packages = with pkgs; [
    kitty
    yazi
  ];
}
