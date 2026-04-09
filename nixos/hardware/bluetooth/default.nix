{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = false;
        FastConnectable = true;
        ControllerMode = "dual";
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;

}
