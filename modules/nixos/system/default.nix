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
      nerd-fonts.jetbrains-mono
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
        serif = [ "JetBrainsMono Nerd Font" "Noto Serif CJK JP" "Noto Serif" "IPAexMincho" ];
        sansSerif = [ "JetBrainsMono Nerd Font" "Noto Sans CJK JP" "Noto Sans" "IPAexGothic" ];
        monospace = [
          "JetBrainsMono Nerd Font Mono"
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK JP"
          "Noto Sans CJK JP"
          "IPAexGothic"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
