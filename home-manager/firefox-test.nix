{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
}: let
  # Import the firefox configuration
  firefoxConfig = import ./firefox.nix {
    config = {};
    pkgs = pkgs;
  };

  # Test helper functions
  assertBool = name: cond:
    if cond
    then pkgs.runCommand "test-${name}-passed" {} "echo 'Test ${name} passed' > $out"
    else throw "Test ${name} failed";

  assertEq = name: expected: actual:
    if expected == actual
    then pkgs.runCommand "test-${name}-passed" {} "echo 'Test ${name} passed: ${toString actual}' > $out"
    else throw "Test ${name} failed: expected ${toString expected}, got ${toString actual}";

  # Extract configuration parts for testing
  firefoxProgram = firefoxConfig.programs.firefox;
  policies = firefoxProgram.policies;
  extensionSettings = policies.ExtensionSettings;
  profiles = firefoxProgram.profiles;
  
  # Extract the extraPolicies from the wrapFirefox call
  # We need to extract this from the firefox.nix file structure
  extraPoliciesConfig = (import ./firefox.nix { inherit pkgs; config = {}; }).programs.firefox.package.override or {};

  tests = {
  # Test that Firefox is enabled
  test-firefox-enabled = assertBool "firefox-enabled" firefoxProgram.enable;

  # Test that essential extensions are configured
  test-ublock-origin = assertBool "ublock-origin-configured" 
    (builtins.hasAttr "uBlock0@raymondhill.net" extensionSettings);

  test-1password = assertBool "1password-configured"
    (builtins.hasAttr "{d634138d-c276-4fc8-924b-40a0ea21d284}" extensionSettings);

  test-privacy-badger = assertBool "privacy-badger-configured"
    (builtins.hasAttr "jid1-MnnxcxisBPnSXQ@jetpack" extensionSettings);

  # Test extension installation mode
  test-extension-installation-mode = assertEq "extension-installation-mode"
    "normal_installed"
    extensionSettings."uBlock0@raymondhill.net".installation_mode;

  # Test that Firefox package is configured (we can't easily test extraPolicies without evaluation)
  test-firefox-package-configured = assertBool "firefox-package-configured"
    (firefoxProgram.package != null);

  # Test profile configuration
  test-default-profile-exists = assertBool "default-profile-exists"
    (builtins.hasAttr "p1ng0ut" profiles);

  test-default-profile-id = assertEq "default-profile-id"
    0
    profiles.p1ng0ut.id;

  test-default-profile-is-default = assertEq "default-profile-is-default"
    true
    profiles.p1ng0ut.isDefault;

  test-secondary-profile-exists = assertBool "secondary-profile-exists"
    (builtins.hasAttr "p3ng0ut" profiles);

  test-secondary-profile-not-default = assertEq "secondary-profile-not-default"
    false
    profiles.p3ng0ut.isDefault;

  # Test homepage settings
  test-default-homepage = assertEq "default-homepage"
    "https://nixos.org"
    profiles.p1ng0ut.settings."browser.startup.homepage";

  test-secondary-homepage = assertEq "secondary-homepage"
    "https://ecosia.org"
    profiles.p3ng0ut.settings."browser.startup.homepage";

  # Test that we have expected number of extensions
  test-extension-count = assertEq "extension-count"
    5
    (builtins.length (builtins.attrNames extensionSettings));
  };

in
tests // {
  # Run all tests
  all-tests = pkgs.runCommand "firefox-tests" {} ''
    echo "Running Firefox configuration tests..."
    
    # Check that all test derivations build successfully
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: test: 
      "echo 'Running ${name}...' && cat ${test}"
    ) tests)}
    
    echo "All Firefox configuration tests passed!" > $out
  '';
}