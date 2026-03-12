{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;
  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = lib.mkAfter [
    pkgs.rocmPackages.rocminfo
    pkgs.rocmPackages.rocm-smi
    pkgs.rocmPackages.rocm-runtime
  ];

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
