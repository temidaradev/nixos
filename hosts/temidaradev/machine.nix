{ config, pkgs, inputs, system, ... }:

let
  globalPackages = import ../packages.nix { inherit pkgs; };
  hostPackages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware/hardware.nix
    ../../modules/nixos
  ];

  temidaradev.hardware.graphics.driver = "amd";

  environment.systemPackages = globalPackages.system ++ hostPackages.system ++ [
    inputs.helium.packages.${system}.default
  ];
}
