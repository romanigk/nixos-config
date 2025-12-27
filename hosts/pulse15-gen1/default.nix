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

  nix.settings.trusted-users = ["root" "p1ng0ut"];

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
    niri = {
      enable = true;
    };
  };

  system.stateVersion = "23.11";
}
