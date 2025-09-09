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

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dunst
    hyprpaper
    hyprpolkitagent
    nautilus
    networkmanagerapplet
    walker
    waybar
    wofi
  ];

  system.stateVersion = "23.11";
}
