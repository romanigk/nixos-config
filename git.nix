{pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "p1ng0ut@mailbox.org";
    userName = "Robert Manigk";
    extraConfig = {
      init.defaultbranch = "main";
      pull.ff = "only";
    };
  };
}
