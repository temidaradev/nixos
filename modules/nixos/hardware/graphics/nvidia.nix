{ config, lib, pkgs, ... }:

lib.mkIf (config.temidaradev.hardware.graphics.driver == "nvidia") {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = lib.mkDefault true;
    open = lib.mkDefault false;
    package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.enableRedistributableFirmware = true;

  users.users.temidaradev.extraGroups = [ "video" "render" ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
