{ ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  systemd.targets = {
    sleep.enable = true;
    suspend.enable = true;
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
      };
    };
  };
}