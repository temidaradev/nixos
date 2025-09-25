{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lunar-client
  ];
}
