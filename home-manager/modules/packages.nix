{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    communication = [
      dino
      discord
      element-desktop
      fluffychat
      signal-desktop
      slack
      # TODO: re-add zoom-us (removed 2026-03-01: upstream download server unreliable)
    ];
    jetbrainsIdesWithPreInstalledPlugins = ide: inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs ide ["com.claude.code.plugin" "org.jetbrains.junie" "nix-idea"];
    devTools = [
      claude-code
      (jetbrainsIdesWithPreInstalledPlugins "idea")
      (jetbrainsIdesWithPreInstalledPlugins "pycharm")
      (jetbrainsIdesWithPreInstalledPlugins "rust-rover")
      (jetbrainsIdesWithPreInstalledPlugins "webstorm")
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
      # TODO: re-add noto-fonts and noto-fonts-color-emoji (removed 2026-03-01: broken noto-fonts-subset derivation in nixpkgs)
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
      # TODO: re-add libreoffice-still (removed 2026-03-01: depends on broken noto-fonts-subset via fontconfig)
    ];
    systemUtils = [
      brightnessctl
      file
      gparted
      mullvad-vpn
      pandoc
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

  fonts.fontconfig.enable = true;
}
