{ config, pkgs, zen-browser, ... }:

{
  imports = [
    ../../modules/home
  ];
  
  home.packages = (import ./packages.nix { inherit pkgs; }).home ++ [
    zen-browser.packages.${pkgs.system}.default
  ];
}
