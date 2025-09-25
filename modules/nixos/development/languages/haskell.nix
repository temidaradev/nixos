{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ghc
    cabal-install
  ];
}
