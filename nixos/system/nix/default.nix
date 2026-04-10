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
      "rusic.cachix.org-1:WXMpGpamblLUiJtcoxBxGGGGwIcWxGPJBUxarLiqWmw="
    ];
    # Ensure DNS works inside fetch sandboxes for fixed-output derivations.
    extra-sandbox-paths = [
      "/etc/resolv.conf"
      "/etc/nsswitch.conf"
      "/etc/hosts"
    ];
  };

  programs.nix-ld.enable = true;
}
