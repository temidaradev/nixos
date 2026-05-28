{ config, lib, ... }:

{
  options.temidaradev.hardware.graphics.driver = lib.mkOption {
    type = lib.types.enum [ "amd" ];
    default = "amd";
  };

  config.hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  imports = [
    ./amd.nix
  ];
}
