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
      efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = ["nodev"];
      useOSProber = true;
      extraEntriesBeforeNixOS = false;
      extraEntries = ''
        menuentry "Omarchy (UEFI - Limine)" {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root 41E9-1D72
          chainloader /EFI/limine/BOOTX64.EFI
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
