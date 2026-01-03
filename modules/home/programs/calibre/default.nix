{ config, pkgs, ... }:

{
  programs.calibre = {
    enable = true;
    package = pkgs.calibre;
  };
}