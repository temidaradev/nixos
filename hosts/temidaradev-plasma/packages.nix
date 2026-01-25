{ pkgs }:

with pkgs; {
  home = [
  ];
  
  system = [
    # Plasma-specific packages
    kdePackages.kdeconnect-kde
    kdePackages.plasma-browser-integration
    kdePackages.kalk
    kdePackages.spectacle
    kdePackages.konsole
    kdePackages.kate
    kdePackages.kwalletmanager
    kdePackages.partitionmanager
    kdePackages.kpmcore
    kdePackages.krfb
    kdePackages.libkscreen
    pkgs.kdePackages.krdp
    wayvnc
  ];
}
