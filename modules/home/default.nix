{ ... }:

{
  imports = [
    ./desktop
    ./development
    ./fonts
    ./programs
  ];

  home.username = "temidaradev";
  home.homeDirectory = "/home/temidaradev";
  home.stateVersion = "25.05";
  
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
