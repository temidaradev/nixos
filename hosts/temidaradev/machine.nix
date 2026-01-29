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

  
  # Use the hyprland package from the local `pkgs` (overlayed above)
  programs.hyprland.package = pkgs.hyprland;

  environment.systemPackages = globalPackages.system ++ hostPackages.system ++ [
    inputs.helium.packages.${system}.default
  ];
}
