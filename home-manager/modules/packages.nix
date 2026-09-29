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
    ];
    devTools = [
      pi-coding-agent
      glab
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
      sox
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
