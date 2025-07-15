{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./firefox.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  accounts.email = {
    accounts."mailbox.org" = {
      primary = true;
      realName = "Robert Manigk";
      address = "romanigk@mailbox.org";
      aliases = ["p1ng0ut@mailbox.org"];

      userName = "romanigk@mailbox.org";
      passwordCommand = "op read op://private/mailbox.org/password";

      imap = {
        host = "imap.mailbox.org";
        port = 993;
      };
      smtp = {
        host = "smtp.mailbox.org";
        port = 465;
      };
      mbsync = {
        enable = true;
        create = "maildir";
      };
      neomutt = {
        enable = true;
        mailboxType = "imap";
      };
      notmuch.enable = true;
      signature = {
        text = ''
          Robert Manigk
          as a private person
        '';
        showSignature = "append";
      };
    };
  };

  home = {
    username = "p1ng0ut";
    homeDirectory = "/home/p1ng0ut";

    packages = with pkgs; [
      claws-mail
      dino
      discord
      element-desktop
      ffmpeg
      file
      gajim
      gimp
      gparted
      jetbrains.idea-ultimate
      jetbrains.rust-rover
      jetbrains.webstorm
      krita
      libreoffice-still
      mediathekview
      meld
      mullvad-vpn
      neomutt
      signal-desktop
      slack
      vlc
      vscode
      xdg-utils
      zoom-us
    ];

    file = {
      ".config/1Password/ssh/agent.toml".source = config/1Password/ssh/agent.toml;
      ".ssh/config".text = ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
      ".config/fish/config.fish".text = ''
        direnv hook fish | source
      '';
    };

    sessionVariables = {
      EDITOR = "nvim";
      SSH_AUTH_SOCK = /home/p1ng0ut/.1password/agent.sock;
    };

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;

    chromium = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userEmail = "p1ng0ut@mailbox.org";
      userName = "Robert Manigk";
      extraConfig = {
        core.editor = "nvim";
        init.defaultBranch = "main";
        pull.ff = "only";
      };
      aliases = {
        adog = "log --all --decorate --oneline --graph";
      };
    };

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-docker
        asvetliakov.vscode-neovim
        yzhang.markdown-all-in-one
        jnoortheen.nix-ide
      ];
    };

    neomutt.enable = true;

    neovim.plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    mbsync.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  systemd.user.startServices = "sd-switch";
}
