{
  config,
  pkgs,
  ...
}: {
  programs.thunderbird = {
    enable = true;
    profiles.p1ng0ut = {
      isDefault = true;
    };
  };
}
