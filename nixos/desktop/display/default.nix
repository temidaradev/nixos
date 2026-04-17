{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.libinput.enable = true;

  services.xserver.xkb = {
    layout = "us,tr";
    variant = "";
  };

  console.keyMap = "us";

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    LIBVA_DRIVER_NAME = "radeonsi";
  };
}
