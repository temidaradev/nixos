{ config, pkgs, zen-browser, ... }:

let
  globalPackages = import ../packages.nix { inherit pkgs; };
  hostPackages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ../../modules/home/development
    ../../modules/home/fonts
    ../../modules/home/programs
    ../../modules/home/desktop/plasma
  ];

  home.username = "temidaradev";
  home.homeDirectory = "/home/temidaradev";
  home.stateVersion = "25.05";
  
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
  
  home.packages = globalPackages.home ++ hostPackages.home ++ [
    zen-browser.packages.${pkgs.system}.default
  ];
}
