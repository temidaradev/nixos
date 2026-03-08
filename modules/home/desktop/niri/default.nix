{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
          };
          repeat-delay = 250;
          repeat-rate = 50;
        };
      };

      cursor = {
        size = 24;
        theme = "Bibata-Modern-Classic";
      };

      environment = {
        XCURSOR_SIZE = "24";
        XCURSOR_THEME = "Bibata-Modern-Classic";
      };
      
      binds = {
        "Mod+Return".action.spawn = "kitty";
        "Mod+Q".action.close-window = {};
        "Mod+A".action.spawn = "rofi -show drun";
        "Mod+R".action.spawn = "rofi -show run";
        "Mod+E".action.spawn = "dolphin";
        "Mod+F".action.fullscreen-window = {};
        "Mod+B".action.spawn = "firefox";
        
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        
        "Print".action.spawn = "grimblast copy area";
        
        "XF86AudioNext".action.spawn = "playerctl next";
        "XF86AudioPause".action.spawn = "playerctl play-pause";
        "XF86AudioPlay".action.spawn = "playerctl play-pause";
        "XF86AudioPrev".action.spawn = "playerctl previous";
        
        "XF86AudioRaiseVolume".action.spawn = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume".action.spawn = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute".action.spawn = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        
        "XF86MonBrightnessUp".action.spawn = "brightnessctl set 5%+";
        "XF86MonBrightnessDown".action.spawn = "brightnessctl set 5%-";
      };

      layout = {
        gaps = 10;
        center-focused-column = "never";
        default-column-width = { proportion = 0.5; };
      };
    };
  };
}
