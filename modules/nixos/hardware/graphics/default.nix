{ config, lib, ... }:

{
  options.temidaradev.hardware.graphics.driver = lib.mkOption {
    type = lib.types.enum [ "amd" "nvidia" ];
    default = "amd";
    description = "Which GPU driver stack to configure.";
  };

  config.hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  imports = [
    ./amd.nix
    ./nvidia.nix
  ];
}
