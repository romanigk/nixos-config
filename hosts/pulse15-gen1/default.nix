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

  # Override GNOME with Hyprland for this host
  services = {
    displayManager.gdm.enable = lib.mkForce false;
    desktopManager.gnome.enable = lib.mkForce false;

    # Enable SDDM for Hyprland
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Remove GNOME-specific packages and add Hyprland essentials
  environment.systemPackages = with pkgs; [
    # Remove gnome-tweaks (inherited from common) and add Hyprland tools
    waybar
    wofi
    wl-clipboard
    grim
    slurp
    swaynotificationcenter
  ];

  system.stateVersion = "23.11";
}
