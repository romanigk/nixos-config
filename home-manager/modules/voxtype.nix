{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.voxtype.homeManagerModules.default];

  programs.voxtype = {
    enable = true;
    package = inputs.voxtype.packages.${pkgs.system}.default;
    # large-v3 is the best multilingual Whisper model with strong German support
    model.name = "large-v3";
    service.enable = true;
    settings = {
      whisper = {
        language = "de";
        translate = false;
      };
    };
  };
}
