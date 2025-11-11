{ pkgs }:

with pkgs; {
  system = [
    # Hyprland-specific system packages
  ];

  home = [
    # Hyprland-specific packages
    rofi
    waybar
    wofi
  ];
}
