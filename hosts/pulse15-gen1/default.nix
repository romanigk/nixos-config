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
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    wl-clipboard
    grim
    slurp
    swaynotificationcenter
  ];

  system.stateVersion = "23.11";
}
