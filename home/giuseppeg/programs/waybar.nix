{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 44;
        spacing = 4;
        margin-top = 6;
        margin-left = 12;
        margin-right = 12;
        modules-left = [
          "group/ws"
          "mpris"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "tray"
          "battery"
          "group/status"
        ];

        # NixOS logo + workspace dots packed into one pill.
        "group/ws" = {
          orientation = "horizontal";
          modules = [
            "custom/logo"
            "hyprland/workspaces"
          ];
        };

        # Network + bluetooth + keep-awake packed into one pill.
        "group/status" = {
          orientation = "horizontal";
          modules = [
            "network"
            "bluetooth"
            "idle_inhibitor"
          ];
        };

        "custom/logo" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          on-click = "activate";
          format = "{icon}";
          "format-icons" = {
            default = "";
            active = "";
            urgent = "";
          };
        };

        clock = {
          format = "{:%H:%M  |  %a, %d %b}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };

        cpu = {
          format = "󰻠 {usage}%";
          tooltip = false;
          on-click = "kitty --class float-btop -e btop";
        };

        memory = {
          format = "󰍛 {percentage}%";
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          "tooltip-format-activated" = "keep awake: on";
          "tooltip-format-deactivated" = "keep awake: off";
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          "format-paused" = "{status_icon} {dynamic}";
          "dynamic-len" = 30;
          "dynamic-order" = [
            "title"
            "artist"
          ];
          "player-icons" = {
            default = "▶";
            spotify = "󰓇";
            firefox = "󰈹";
            chromium = "󰊯";
            mpv = "";
            vlc = "󰕼";
          };
          "status-icons" = {
            paused = "⏸";
          };
          on-click = "playerctl play-pause";
          "on-click-right" = "playerctl next";
          "on-scroll-up" = "playerctl volume 0.05+";
          "on-scroll-down" = "playerctl volume 0.05-";
          "tooltip-format" = "{title} — {artist}";
        };

        tray = {
          "icon-size" = 18;
          spacing = 10;
        };

        network = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 Ethernet";
          format-linked = "󰈀 (No IP)";
          format-disconnected = "󰖪 Disconnected";
          tooltip-format = "{ifname} via {gwaddr} ";
          on-click = "kitty --class float-network -e nmtui";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          "format-muted" = "󰝟 muted";
          "format-icons" = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            headphone = "󰋋";
            headset = "󰋎";
          };
          "scroll-step" = 5;
          on-click = "pamixer -t";
          "on-click-right" = "pavucontrol";
          "tooltip-format" = "{desc}  {volume}%";
        };

        bluetooth = {
          format = "󰂯";
          "format-disabled" = "󰂲";
          "format-off" = "󰂲";
          "format-connected" = "󰂱 {device_alias}";
          on-click = "blueman-manager";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{device_enumerate}";
        };
      };
    };
  };
}
