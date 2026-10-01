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
      proggyfonts
    ];
    multimedia = [
      ffmpeg
      gimp
      krita
      mediathekview
      vlc
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
    ++ systemUtils;

  fonts.fontconfig.enable = true;
}
