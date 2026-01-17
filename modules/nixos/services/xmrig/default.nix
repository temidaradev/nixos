{ config, pkgs, ... }:

{
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = true;
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "pool.supportxmr.com:443";
          user = "44DxqQQLEUP6gvqeUt7UiuSvUJQSTXsv3fwREzaGNEJVX73oEvityWX6kPBQBtmSCV7GLvVg1c3oQDQNT8BLosbe5WSSrni";
          keepalive = true;
          tls = true;
        }
      ];
      http = {
        enabled = true;
        host = "127.0.0.1";
        port = 8080;
        access-token = "admin";
        restricted = false;
      };
    };
  };

  systemd.services.xmrig.wantedBy = pkgs.lib.mkForce [];
}
