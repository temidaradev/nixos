{ config, pkgs, ... }:

{
  hardware.keyboard.qmk.enable = true;
  
  services.udev.packages = with pkgs; [
    qmk-udev-rules
    via
  ];
  
  users.groups.plugdev = {};
  
  environment.systemPackages = with pkgs; [
    qmk
    via
    vial
    gcc-arm-embedded
    pkgsCross.avr.buildPackages.gcc
    pkgsCross.avr.avrlibc
    avrdude
    dfu-programmer
    dfu-util
  ];
}
