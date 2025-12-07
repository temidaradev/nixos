{ config, pkgs, inputs, system, ... }:

let
  globalPackages = import ../packages.nix { inherit pkgs; };
  hostPackages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware/hardware.nix
    ../../modules/nixos/boot
    ../../modules/nixos/gaming
    ../../modules/nixos/hardware
    ../../modules/nixos/networking
    ../../modules/nixos/services
    ../../modules/nixos/system
    ../../modules/nixos/users
    ../../modules/nixos/virtualization
    ../../modules/nixos/desktop/display
    ../../modules/nixos/desktop/audio
    ../../modules/nixos/desktop/window-managers/plasma.nix
  ];

  environment.systemPackages = globalPackages.system ++ hostPackages.system ++ [
    inputs.helium.packages.${system}.default
  ];
}
