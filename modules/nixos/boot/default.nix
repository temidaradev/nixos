{ config, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = false;

  boot.kernelParams = [
    "amd_pstate=active"
  ];

  boot.loader = {
    timeout = 10;

    efi = {
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = ["nodev"];
      useOSProber = true;
      extraEntriesBeforeNixOS = false;

      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };
}
