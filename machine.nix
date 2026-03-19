{ pkgs, inputs, system, ... }:

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
    inputs.zen-browser.packages.${system}.default
    inputs.noctalia.packages.${system}.default
    inputs.noctalia-qs.packages.${system}.default
    inputs.rusic.packages.${system}.default
  ];
}
