{ config, pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font Mono" "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" "Noto Sans CJK JP" ];
      serif     = [ "JetBrainsMono Nerd Font" "Noto Serif CJK JP" ];
    };
  };
}
