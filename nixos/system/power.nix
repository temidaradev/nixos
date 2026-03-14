{ ... }:

{
  boot.kernelParams = [ 
    "processor.max_cstate=1"
    "amd_pstate=active"
  ];

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  services.power-profiles-daemon.enable = true;
}
