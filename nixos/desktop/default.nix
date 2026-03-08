{ pkgs, ... }:

{
  imports = [
    ./display
    ./window-managers
    ./audio
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
