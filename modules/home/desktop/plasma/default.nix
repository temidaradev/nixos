{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.spectacle
    kdePackages.kio
    kdePackages.kio-extras
    libnotify
  ];
  
  # Modern notification settings
  home.file.".config/plasmanotifyrc".text = ''
    [Notifications]
    PopupPosition=TopRight
    PopupTimeout=5000
    
    [DoNotDisturb]
    Enabled=false
  '';
}
