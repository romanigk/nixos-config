{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  networking.hostName = "pulse15-gen1";

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      xwayland.enable = true;
    };
    niri = {enable = false;};
  };

  system.stateVersion = "23.11";
}
