{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnumake
    unzip
    btop
    fastfetch
    arduino-ide
    ddcutil
    brightnessctl
    networkmanager
    lm_sensors
    fish
    aubio
    pipewire
    swappy
    libqalculate
    material-symbols
    nerd-fonts.caskaydia-cove
  ];
}
