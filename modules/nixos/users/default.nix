{ config, pkgs, ... }:

{
  users.users.temidaradev = {
    isNormalUser = true;
    description = "temidaradev";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
}
