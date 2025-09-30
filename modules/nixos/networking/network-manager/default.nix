{ config, pkgs, ... }:

{
  networking.hostName = "temidaradev";
  networking.networkmanager.enable = true;
}
