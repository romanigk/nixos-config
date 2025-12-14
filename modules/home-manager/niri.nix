{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs = {
    niri = {
      enable = true;
    };
    waybar = {
        enable = true;
      };
  };

  home.packages = with pkgs; [
    dunst
    grim
    kitty
    nautilus
    networkmanagerapplet
    slurp
    walker
    waybar
    wl-clipboard
    wofi
    yazi
  ];
}
