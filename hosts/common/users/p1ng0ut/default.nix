{ pkgs, config, lib, ...}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  in {
    users.mutableUsers = false;
    users.users.p1ng0ut = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = ifTheyExist [
        "audio"
	"docker"
	"git"
	"networkmanager":
	"podman"
	"video"
	"wheel"
      ];
    };
  }
