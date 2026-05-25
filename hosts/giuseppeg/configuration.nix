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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      USB_AUTOSUSPEND = 1;

      # Preserve battery health: charge to 80%, resume below 75%.
      # Bump STOP to 100 before a long unplugged trip.
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  services.power-profiles-daemon.enable = false;

  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 3;
    criticalPowerAction = "HybridSleep";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  # Auto-mount removable USB drives.
  # Drives appear at /run/media/<user>/<label>.
  # The udiskie daemon (which actually performs the mounting) is configured
  # per-user in home-manager (home/giuseppeg/home.nix).
  services.udisks2.enable = true;

  # Local single-node Kubernetes via k3s.
  # Kubeconfig is written world-readable at /etc/rancher/k3s/k3s.yaml so
  # kubectl works without sudo (see KUBECONFIG in home.nix).
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [ "--write-kubeconfig-mode=644" ];
  };
}
