{ config, pkgs, lib, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  systemd.user.services.uxplay = {
    description = "UXPlay AirPlay Receiver";
    after = [ "graphical-session.target" "network-online.target" ];
    wants = [ "graphical-session.target" "network-online.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.uxplay}/bin/uxplay -n ${config.networking.hostName} -nh -p";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };

  networking.firewall.allowedTCPPorts = lib.mkAfter [
    7000
    7001
    7100
  ];

  networking.firewall.allowedUDPPorts = lib.mkAfter [
    5353
    6000
    6001
    7011
  ];
}
