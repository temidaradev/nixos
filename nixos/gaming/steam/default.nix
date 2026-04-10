{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  programs.gamescope.enable = true;

  # Improve gamepad compatibility, especially for Steam Input and newer controllers.
  hardware.steam-hardware.enable = true;
}
