{ config, pkgs, caelestia-shell, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [ "HDMI-A-1,1920x1080@120,auto,1,0" ];

      input = {
        kb_layout = "tr";
        repeat_delay = 250;
        repeat_rate = 50;
      };

      cursor = {
        no_hardware_cursors = false;
        enable_hyprcursor = true;
        hide_on_key_press = false;
        hide_on_touch = true;
      };

      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
      ];
      
      bind = [
        "SUPER, RETURN, exec, kitty"
        "SUPER, Q, killactive"
        "SUPER, A, exec, rofi -show drun"
        "SUPER, R, exec, rofi -show run"
        "SUPER, E, exec, dolphin"
        "SUPER, F, fullscreen"
        "SUPER, B, exec ,firefox"
        
        "ALT, SPACE, exec, caelestia shell drawers toggle launcher"
        "SUPER, D, exec, caelestia shell drawers toggle dashboard"
        "SUPER, S, exec, caelestia shell drawers toggle session"
        "SUPER, U, exec, caelestia shell drawers toggle utilities"
        "SUPER, N, exec, caelestia shell notifs clear"
        "SUPER SHIFT, L, exec, caelestia shell lock lock"
        
        "SUPER, F7, exec, playerctl previous"
        "SUPER, F8, exec, playerctl play-pause"
        "SUPER, F9, exec, playerctl next"
        "SUPER, F10, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        "SUPER, F11, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        "SUPER, F12, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
      ];
      
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindl = [ 
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
        
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      exec-once = [
        "pkill -f swayidle || true"
        "pkill -f swaylock || true"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
        };
      };
    };
    extraConfig = ''
      # Disable idle timeout and screen lock
      exec-once = [hyprctl dispatch dpms on]
      
      # Additional Hyprland configuration can go here if needed
    '';
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "Arc-Dark";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = false;
    };
  };
}
