{ pkgs, ... }:

{
  imports = [
    ./locale
    ./nix
    ./power.nix
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      ipaexfont
    ];

    fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        style = "slight";
        autohint = false;
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };

      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" "IPAexMincho" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" "IPAexGothic" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK JP" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
