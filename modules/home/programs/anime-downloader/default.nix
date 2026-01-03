{ config, pkgs, ... }:

{
    programs.anime-downloader = {
        enable = true;
        package = pkgs.anime-downloader;
    };
}