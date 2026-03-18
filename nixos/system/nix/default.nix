{ config, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://rusic.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "rusic.cachix.org-1:MOGziktypGKowFadUrGkjdqR1V1xACs+Mt1+WDF3w/s="
    ];
  };

  programs.nix-ld.enable = true;
}
