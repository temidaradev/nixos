{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    # capSysNice must stay false: with gamescopeSession.enable, the steam module
    # otherwise creates a setuid bwrap wrapper that nixpkgs' non-setuid bubblewrap
    # rejects ("setuid use of bubblewrap is not supported in this build").
    capSysNice = false;
  };

  hardware.steam-hardware.enable = true;
}
