{ config, pkgs, ... }:

{
  imports = [
    ./hardware/hardware.nix
    ../../modules/nixos
  ];

  environment.systemPackages = (import ./packages.nix { inherit pkgs; }).system;
}