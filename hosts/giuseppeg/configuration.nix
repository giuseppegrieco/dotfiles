{ config, pkgs, ... }:

{
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4096;
    }
  ];

  networking.hostName = "giuseppeg";
}
