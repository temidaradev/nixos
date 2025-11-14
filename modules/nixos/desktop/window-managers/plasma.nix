{ config, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kdeconnect-kde
    kdePackages.plasma-browser-integration
    kdePackages.plasma-pa
    kdePackages.plasma-workspace
    kdePackages.kwin
    kdePackages.plasma-desktop
    kdePackages.plasma-systemmonitor
    kdePackages.kio-extras
    kdePackages.kio-fuse
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    KWIN_TRIPLE_BUFFER = "1";
    KWIN_DRM_USE_MODIFIERS = "1";
    KWIN_COMPOSE = "O2";
  };

  services.xserver.enable = true;
  
  programs.dconf.enable = true;
  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style = "breeze";
  
  services.displayManager.sessionPackages = [ pkgs.kdePackages.plasma-workspace ];
  
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting.enable = true;
    hinting.style = "slight";
    subpixel.rgba = "rgb";
  };
  
  programs.kdeconnect.enable = true;
  
  hardware.graphics.enable = true;
  
  systemd.user.services.plasma-plasmashell = {
    serviceConfig = {
      Slice = "session.slice";
      CPUWeight = 100;
      IOWeight = 100;
    };
  };
}
