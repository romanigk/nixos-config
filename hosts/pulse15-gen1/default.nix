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
    xserver.xkb = {
      layout = "us,de";
      options = "grp:win_space_toggle";
    };
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

  # Standardized across all hosts for consistency.
  # Changing stateVersion may affect stateful services - test after switching.
  system.stateVersion = "25.05";
}
