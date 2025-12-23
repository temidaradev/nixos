{ config, pkgs, ... }:

{
  services.monero = {
    enable = true;
    dataDir = "/var/lib/monero";
    rpc.port = 18081;
    extraConfig = ''
      prune-blockchain=1
      confirm-external-bind=1
    '';
  };
}
