{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      alias = {
        adog = "log --all --decorate --oneline --graph";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.ff = "only";
      user.email = "p1ng0ut@mailbox.org";
      user.name = "Robert Manigk";
    };
  };
}
