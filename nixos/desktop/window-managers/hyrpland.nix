{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}
