{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    package = pkgs.mesa;
    package32 = pkgs.driversi686Linux.mesa;

    extraPackages = with pkgs; [
      mesa
      amdvlk

      libGL
      libglvnd
      libva
      vaapiVdpau
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    extraPackages32 = with pkgs.driversi686Linux; [
      mesa
      amdvlk
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
