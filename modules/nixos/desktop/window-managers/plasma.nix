{ config, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable KDE Plasma
  environment.systemPackages = with pkgs; [
    kdePackages.kdeconnect-kde
    kdePackages.plasma-browser-integration
    kdePackages.plasma-pa
    kdePackages.plasma-workspace
  ];

  # Ensure X11 and Wayland support
  services.xserver.enable = true;
  
  # Enable Qt theming
  programs.dconf.enable = true;
  qt.enable = true;
  qt.platformTheme = "kde";
}
