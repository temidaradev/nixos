{ config, pkgs, ... }:

{
  virtualisation.vmware.host.enable = true;
  
  environment.systemPackages = with pkgs; [
    vmware-workstation
  ];
}
