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

  home.packages = with pkgs; [ ];
}
