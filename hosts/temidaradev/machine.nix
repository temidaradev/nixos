{ config, pkgs, ... }:

{
  imports = [
    ./hardware/hardware.nix
    ../../modules/nixos
  ];
}