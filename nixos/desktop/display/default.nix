{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      General = {
        DisplayServer = "wayland";
      };
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  console.keyMap = "us";

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    LIBVA_DRIVER_NAME = "radeonsi";
    AQ_NO_MODIFIERS = "1";
  };
}
