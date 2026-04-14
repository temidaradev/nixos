{ config, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "amd_pstate=active"
  ];

  boot.loader = {
    timeout = 10;

    efi = {
      efiSysMountPoint = "/boot";
    };

    grub.enable = false;
    systemd-boot.enable = true;
  };
}
