{ config, lib, pkgs, ... }:

{
  home.username = "p1ng0ut";
  home.homeDirectory = "/home/p1ng0ut";
  home.stateVersion = "23.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    _1password-gui
    _1password
    firefox
    thunderbird
    dino
    meld
    jetbrains.idea-ultimate
    element-desktop
    signal-desktop
    direnv
    mullvad-vpn
    (nerdfonts.override { fonts = ["FiraCode" "FantasqueSansMono"]; })
  ];

  home.file = {
    ".config/1Password/ssh/agent.toml".source = config/1Password/ssh/agent.toml;
    ".ssh/config".text = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SSH_AUTH_SOCK=/home/p1ng0ut/.1password/agent.sock;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git = {
      enable = true;
      userEmail = "p1ng0ut@mailbox.org";
      userName = "Robert Manigk";
      extraConfig = {
        init.defaultBranch = "main";
        pull.ff = "only";
      };
      aliases = {
        pu = "push";
        co = "checkout";
        cm = "commit";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
