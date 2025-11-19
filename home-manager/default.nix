{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/home-manager/firefox.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
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

  fonts.fontconfig.enable = true;

  home = {
    username = "p1ng0ut";
    homeDirectory = "/home/p1ng0ut";

    packages = with pkgs; let
      communication = [
        dino
        discord
        element-desktop
        signal-desktop
        slack
        zoom-us
      ];
      devTools = [
        jetbrains.idea-ultimate
        jetbrains.rust-rover
        jetbrains.webstorm
        meld
        vscode
      ];
      email = [
        claws-mail
      ];
      fonts = [
        font-awesome
        liberation_ttf
        mplus-outline-fonts.githubRelease
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-color-emoji
        proggyfonts
      ];
      multimedia = [
        ffmpeg
        gimp
        krita
        mediathekview
        vlc
      ];
      officeTools = [
        libreoffice-still
      ];
      systemUtils = [
        file
        gparted
        mullvad-vpn
        xdg-utils
      ];
    in
      communication
      ++ devTools
      ++ email
      ++ fonts
      ++ multimedia
      ++ officeTools
      ++ systemUtils;

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
      SSH_AUTH_SOCK = "~/.1password/agent.sock";
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
