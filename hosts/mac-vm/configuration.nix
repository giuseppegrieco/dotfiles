# VM-specific configuration for the `mac-vm` host.

{ config, pkgs, ... }:

{
  imports = [
    # Shared system configuration.
    ../shared/configuration.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # VM swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4096;
    }
  ];

  # Host name
  networking.hostName = "mac-vm";

  # Needed for the aarch64 VM — kept host-specific.
  nixpkgs.config.allowUnsupportedSystem = true;

  # Enable QEMU Guest Agent for integration
  services.qemuGuest.enable = true;

  # Enable Spice VDAgent for clipboard sharing and dynamic resizing
  services.spice-vdagentd.enable = true;

  # Enable WebDAV for folder sharing
  services.spice-webdavd.enable = true;
}
