{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;
  hardware.amdgpu.opencl.enable = true;

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
