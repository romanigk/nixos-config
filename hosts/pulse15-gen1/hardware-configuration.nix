{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4a93fb93-8323-4659-9a8f-2f05f98e8401";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-8bd423bd-94c6-4e05-8567-79e6b9c62c3f".device = "/dev/disk/by-uuid/8bd423bd-94c6-4e05-8567-79e6b9c62c3f";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/68AB-3E4F";
    fsType = "vfat";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}