{ pkgs, config, lib, ... }:

let
  inherit (lib) mkAfter;
in

{
  nix.enable = false;

  time.timeZone = "Europe/Istanbul";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      "com.apple.springing.enabled" = true;
      "com.apple.springing.delay" = 0.0;
    };
    CustomSystemPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
        allowIdentifierForAdvertising = false;
        forceLimitAdTracking = true;
        personalizedAdsMigrated = false;
      };
    };
    dock = {
      autohide = true;
      orientation = "bottom";
      tilesize = 48;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      NewWindowTarget = "Home";
      FXPreferredViewStyle = "Nlsv";
    };
    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
    };
    LaunchServices.LSQuarantine = false;
  };

  system.activationScripts.postActivation.text = mkAfter ''
    echo "unhiding ${config.users.users.${config.system.primaryUser}.home}/Library..."
    /usr/bin/chflags nohidden ${config.users.users.${config.system.primaryUser}.home}/Library
  '';
}
