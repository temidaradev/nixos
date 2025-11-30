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

      extraEntries = ''
        menuentry "Bazzite" {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root 4CFA-C5B1
          chainloader /EFI/fedora/shimx64.efi
        }
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
