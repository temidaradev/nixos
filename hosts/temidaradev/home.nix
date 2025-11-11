{ config, pkgs, zen-browser, ... }:

let
  globalPackages = import ../packages.nix { inherit pkgs; };
  hostPackages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ../../modules/home
  ];
  
  home.packages = globalPackages.home ++ hostPackages.home ++ [
    zen-browser.packages.${pkgs.system}.default
  ];
}
