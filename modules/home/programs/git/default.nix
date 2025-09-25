{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "temidaradev";
    userEmail = "temidaradev@proton.me";
  };
}
