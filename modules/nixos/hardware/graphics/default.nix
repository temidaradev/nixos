{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qt6.full
  ];
}
