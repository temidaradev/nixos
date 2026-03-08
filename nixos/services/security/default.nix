{ config, pkgs, ... }:

{
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  security.wrappers.gsr-kms-server = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
  };
}
