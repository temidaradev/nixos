{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    KERNEL=="ttyACM[0-9]*", MODE="0666"
  '';
}
