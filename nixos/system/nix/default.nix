{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.nix-ld.enable = true;

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://rusic.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "rusic.cachix.org-1:WXMpGpamblLUiJtcoxBxGGGGwIcWxGPJBUxarLiqWmw="
    ];
  };
}

