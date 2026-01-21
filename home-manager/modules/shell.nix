{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/fish/config.fish".text = ''
    direnv hook fish | source
  '';
}