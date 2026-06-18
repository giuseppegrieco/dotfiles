{
  config,
  pkgs,
  lib,
  ...
}:

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

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "on";

      USB_AUTOSUSPEND = 0;

      # Preserve battery health: charge to 80%, resume below 75%.
      # Bump STOP to 100 before a long unplugged trip.
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Disable USB runtime autosuspend kernel-wide so idle USB hubs are never
  # suspended. TLP's USB_AUTOSUSPEND=0 only stops TLP from *enabling* it; the
  # kernel default (usbcore.autosuspend=2) would still suspend idle hubs and
  # drop whatever sits behind them.
  boot.kernelParams = [
    "usbcore.autosuspend=-1"
    "snd_intel_dspcfg.dsp_driver=3"
    "snd_hda_intel.dmic_detect=1"
  ];

  # Firmware updates (Lenovo BIOS + ThinkPad USB4 dock) via LVFS/fwupd.
  # The dock and laptop are new; their firmware has never been updated under
  # Linux. Dock/BIOS firmware is the standard root-cause fix for USB devices
  # that won't enumerate at boot until replugged. `fwupdmgr get-devices` to
  # list, `fwupdmgr update` to apply.
  services.fwupd.enable = true;

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

  # Thunderbolt / USB4 device manager (boltd).
  # The ThinkPad USB4 dock sits behind Thunderbolt security level "user", so its
  # router comes up authorized=0 at cold boot and only partially enumerates.
  # boltd lets the dock be enrolled once (`boltctl enroll <uuid>`) so it is
  # authorized automatically on every boot. Also provides the `boltctl` CLI.
  services.hardware.bolt.enable = true;

  # Auto-mount removable USB drives.
  # Drives appear at /run/media/<user>/<label>.
  # The udiskie daemon (which actually performs the mounting) is configured
  # per-user in home-manager (home/giuseppeg/home.nix).
  services.udisks2.enable = true;

  # Local single-node Kubernetes via k3s.
  # Kubeconfig is written world-readable at /etc/rancher/k3s/k3s.yaml so
  # kubectl works without sudo (see KUBECONFIG in home.nix).
  # Service is installed but does not autostart at boot — use the
  # `k3s-start` / `k3s-stop` zsh aliases to control it on demand.
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [ "--write-kubeconfig-mode=644" ];
  };
  systemd.services.k3s.wantedBy = lib.mkForce [ ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;
}
