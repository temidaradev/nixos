{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home
  ];

  home.packages = (import ./packages.nix { inherit pkgs; }).home;
}