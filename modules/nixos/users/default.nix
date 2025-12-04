{ config, pkgs, ... }:

{
  users.users.temidaradev = {
    isNormalUser = true;
    description = "temidaradev";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
}
