{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    unzip
    btop
    fastfetch
    arduino-ide
  ];
}
