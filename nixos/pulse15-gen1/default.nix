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

  # Host-specific configuration for pulse15-gen1
  networking.hostName = "pulse15-gen1";

  # Add any pulse15-gen1 specific configuration here
  # For example:
  # - Display configuration for this specific laptop
  # - Battery optimization settings
  # - Hardware-specific services

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
