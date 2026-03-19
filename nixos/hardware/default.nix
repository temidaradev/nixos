{ ... }:

{
  imports = [
    ./bluetooth
    ./graphics
    ./udev
    ./keyboard
    ./otd
  ];

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
