{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      Wayland = {
        EnableHiDPI = "false";
      };
    };
  };
  
  services.desktopManager.plasma6.enable = true;
  
  environment.sessionVariables = {
    KWIN_FORCE_REFRESH_RATE = "120";
  };

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

  services.xserver.enable = true;
  
  programs.dconf.enable = true;
  
  programs.kdeconnect.enable = true;
  
  hardware.graphics.enable = true;
}
