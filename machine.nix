{ config, pkgs, inputs, system, zen-browser, ... }:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware.nix
    ./nixos
  ];

  environment.systemPackages = packages.system ++ [
    inputs.helium.packages.${system}.default
    zen-browser.packages.${system}.default
  ];
}