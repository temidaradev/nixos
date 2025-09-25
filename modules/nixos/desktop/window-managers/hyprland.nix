{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
