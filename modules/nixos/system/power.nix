{ ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

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
}