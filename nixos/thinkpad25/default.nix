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

  # Host-specific configuration for thinkpad25
  networking.hostName = "thinkpad25";

  # Add any thinkpad25 specific configuration here
  # For example:
  # - TrackPoint configuration
  # - Display scaling for different screen
  # - Hardware-specific services
  # - Different power management settings
}