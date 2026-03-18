{ pkgs, lib, ... }:

{
  imports = [
    ./display
    ./window-managers
    ./audio
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "image/gif" = "org.kde.gwenview.desktop";
      "image/bmp" = "org.kde.gwenview.desktop";
      "image/svg+xml" = "org.kde.gwenview.desktop";
      "image/webp" = "org.kde.gwenview.desktop";
      "image/tiff" = "org.kde.gwenview.desktop";
    };
  };

  xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config.niri.default = [ "gnome" "gtk" ];
    };
}
