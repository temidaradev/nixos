{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
  };

  services.displayManager.defaultSession = "niri";
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
