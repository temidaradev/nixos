{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lua
  ];
}
