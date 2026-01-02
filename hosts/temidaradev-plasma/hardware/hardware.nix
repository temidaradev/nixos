{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  temidaradev.hardware.graphics.driver = "amd";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 5;
    "vm.vfs_cache_pressure" = 50;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/663b49b4-140f-4e31-83dd-bb45c1b9d308";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/418A-71BC";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  
  fileSystems."/mnt/1TB-HDD" = {
    device = "/dev/disk/by-uuid/d870dc25-8190-44c5-8bc8-26a8f557aed3";
    fsType = "ext4";
    options = [
      "rw"
      "noatime"
      "nodiratime"
      "commit=60"
    ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 12*1024; # 12 GB
  }];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
