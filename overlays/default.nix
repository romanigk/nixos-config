# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    vscode-extensions = prev.vscode-extensions // {
      anthropic = prev.vscode-extensions.anthropic // {
        claude-code = prev.vscode-extensions.anthropic.claude-code.overrideAttrs (_: {
          src = prev.fetchurl {
            name = "anthropic-claude-code.vsix";
            url = "https://anthropic.gallery.vsassets.io/_apis/public/gallery/publisher/anthropic/extension/claude-code/2.1.92/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
            sha256 = "sha256-f+6xXZVb5sYrmrH7eoon6/QoQaTnBuTnb+YnvszqyKA=";
          };
        });
      };
    };
  };
}
