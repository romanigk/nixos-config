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
      zoom-us
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
