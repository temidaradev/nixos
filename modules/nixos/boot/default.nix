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
        menuentry "BazziteOS (Samsung EVO)" {
          insmod part_gpt
          insmod fat
          # Use the EFI system partition on the Samsung EVO (from blkid):
          # UUID="4CFA-C5B1" (device: /dev/sdb1). Replace with a
          # different UUID if yours differs.
          search --no-floppy --fs-uuid --set=root 4CFA-C5B1 || true

          # Try common EFI loader locations (adjust if Bazzite uses a
          # different path).
          # `$root` must be escaped so Nix doesn't try to interpolate it.
          chainloader (\$root)/EFI/BOOT/bootx64.efi
          boot
        }
      '';
    };
  };
}
