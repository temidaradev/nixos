{ config, pkgs, ... }:

{
  home.username = "temidaradev";
  home.homeDirectory = "/home/temidaradev";

  programs.git = {
    enable = true;
    userName = "temidaradev";
    userEmail = "temidaradev@proton.me";
  };

  home.stateVersion = "25.05";

  home.packages = [
    pkgs.noto-fonts-cjk-sans
  ];

  home.file = {
    ".local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" = {
      source = ./assets/JetBrainsMonoNerdFont-Regular.ttf;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" "Noto Sans CJK JP" ];
      serif     = [ "JetBrainsMono Nerd Font" "Noto Serif CJK JP" ];
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/temidaradev/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
