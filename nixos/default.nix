{ ... }:

{
  imports = [
    ../shared/git.nix
    ./boot
    ./desktop
    ./gaming
    ./hardware
    ./networking
    ./services
    ./system
    ./users
    ./virtualization
  ];
}
