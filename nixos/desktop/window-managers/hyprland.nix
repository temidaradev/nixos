{ config, pkgs, inputs, system, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.uwsm.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = (with pkgs; [
    kitty
    wofi
    waybar
    hyprpaper
    hyprlauncher
  ]) ++ [
    inputs.caelestia-shell.packages.${system}.default
  ];
}
