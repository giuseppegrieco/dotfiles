{ ... }:

{
  # Auto-mount removable USB drives at /run/media/<user>/<label>.
  # Needs services.udisks2 enabled at the system level (configuration.nix).
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "never";
  };
}
