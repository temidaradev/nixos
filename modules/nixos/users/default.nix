{ config, pkgs, ... }:

{
  users.users.temidaradev = {
    isNormalUser = true;
    description = "temidaradev";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      thunderbird
      firefox
      slack
      discord
      telegram-desktop
      youtube-music
      blender
      godot
      kitty
      ghostty
      waybar
      kdePackages.dolphin
      wofi
      wl-clipboard
      wine
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
}
