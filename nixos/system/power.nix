{ ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
  
  # AMD CPU performance optimizations
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

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "ignore";
        HandleSuspendKey = "suspend";
        HandleHibernateKey = "ignore";
        IdleAction = "ignore";
        IdleActionSec = 0;
        KillUserProcesses = false;
        UserStopDelaySec = 0;
      };
    };
  };
  
  # CPU governor for better performance
  services.power-profiles-daemon.enable = false;
  
  # Disable USB autosuspend to prevent lag
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
  '';
}