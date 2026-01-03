{ pkgs, ... }:

{
  programs.anime-downloader.enable = true;
  home.packages = with pkgs; [
    anime-downloader
    ani-cli
  ];
}