# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    # 1Password
    inputs._1password-shell-plugins.hmModules.default
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "p1ng0ut";
    homeDirectory = "/home/p1ng0ut";

    packages = with pkgs; [
      firefox
      thunderbird
      dino
      meld
      jetbrains.idea-ultimate
      element-desktop
      signal-desktop
      vscode
      direnv
      mullvad-vpn
    ];

    file = {
      ".config/1Password/ssh/agent.toml".source = config/1Password/ssh/agent.toml;
    };

    sessionVariables = {
      EDITOR = "nvim";
      SSH_AUTH_SOCK = /home/p1ng0ut/.1password/agent.sock;
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;

    _1password-shell-plugins = {
      enable = true;
      plugins = with pkgs; [gh awscli2 cachix];
    };

    firefox.enable = true;

    git = {
      enable = true;
      userEmail = "p1ng0ut@mailbox.org";
      userName = "Robert Manigk";
      extraConfig = {
        init.defaultBranch = "main";
        pull.ff = "only";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    ssh = {
      enable = true;
      extraConfig = ''
        Host *
          IdentityAgent "~/.1password/agent.sock"
      '';
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-docker
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
