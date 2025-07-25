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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad25";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  users.users.p1ng0ut = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    gnome-tweaks
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
