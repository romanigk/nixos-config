{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs = {
    waybar = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    alacritty
    fuzzel
    swaylock
  ];
}
