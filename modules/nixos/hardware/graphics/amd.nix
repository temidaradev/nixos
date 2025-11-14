{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    package = pkgs.mesa;
    package32 = pkgs.driversi686Linux.mesa;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      
      mesa
      libGL
      libglvnd
      
      libva
      libva-vdpau-driver
      libvdpau-va-gl
      
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      vulkan-extension-layer
    ];

    extraPackages32 = with pkgs.driversi686Linux; [
      mesa
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  
  boot.kernelParams = [
    "amdgpu.dc=1"
    "amdgpu.gpu_recovery=1"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.amdgpu.opencl.enable = true;
  
  environment.variables = {
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    AMD_VULKAN_ICD = "RADV";
    RADV_PERFTEST = "sam,nggc,rt";
  };
}
