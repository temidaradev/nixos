{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    libGL
    glm
    glfw
    mesa
    stdenv.cc.cc.lib
    zlib
    ncurses
    pkg-config
  ];
}
