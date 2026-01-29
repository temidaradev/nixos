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
    "amdgpu.dpm=1"
    "amdgpu.runpm=0"
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.amdgpu.opencl.enable = true;
  
  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-runtime
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    libdrm
    clinfo
  ];
  
  users.users.temidaradev.extraGroups = [ "video" "render" ];
  
  services.udev.extraRules = ''
    KERNEL=="card[0-9]*", SUBSYSTEM=="drm", MODE="0666"
    KERNEL=="renderD[0-9]*", SUBSYSTEM=="drm", MODE="0666"
    KERNEL=="hwmon[0-9]*", SUBSYSTEM=="hwmon", SUBSYSTEMS=="pci", ATTRS{vendor}=="0x1002", MODE="0644"
    
    # Allow GPU to manage power dynamically for better boost behavior
    SUBSYSTEM=="pci", DRIVER=="amdgpu", ATTR{power/control}="on"
  '';
  
  environment.variables = {
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    AMD_VULKAN_ICD = "RADV";
    RADV_PERFTEST = "gpl";
    mesa_glthread = "true";
    ROC_ENABLE_PRE_VEGA = "1";
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
  };
  
  systemd.tmpfiles.rules = [
    "L+ /usr/lib/libdrm_amdgpu.so.1 - - - - ${pkgs.libdrm}/lib/libdrm_amdgpu.so.1"
  ];
}
