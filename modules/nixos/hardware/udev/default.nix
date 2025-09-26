{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    KERNEL=="ttyACM[0-9]*", MODE="0666"
  '';

  services.udisks2.enable = true;
  
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id.match("org.freedesktop.udisks2.") &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
}
