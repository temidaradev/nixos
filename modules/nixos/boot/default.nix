{ config, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = false;

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
    };
  };
}
