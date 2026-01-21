{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  networking.hostName = "thinkpad25";

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];

  # Standardized across all hosts for consistency.
  # New hosts should use this same version.
  system.stateVersion = "25.05";
}
