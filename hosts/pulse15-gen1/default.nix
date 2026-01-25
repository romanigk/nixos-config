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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
        user = "greeter";
      };
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
