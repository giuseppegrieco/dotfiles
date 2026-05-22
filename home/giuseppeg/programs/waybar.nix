{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        margin-top = 6;
        margin-left = 12;
        margin-right = 12;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "network"
          "bluetooth"
          "pulseaudio"
          "battery"
          "tray"
        ];

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
          format = "CPU {usage}%";
          tooltip = false;
        };

        memory = {
          format = "RAM {}%";
        };

        tray = {
          "icon-size" = 18;
          spacing = 10;
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  Ethernet";
          format-linked = "󰈀  (No IP)";
          format-disconnected = "󰖪  Disconnected";
          tooltip-format = "{ifname} via {gwaddr} ";
          on-click = "kitty --class float-network -e nmtui";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          "format-muted" = "󰝟  muted";
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

    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: transparent;
        color: ${base05};
      }

      #workspaces,
      #clock,
      #cpu, #memory, #network, #bluetooth, #pulseaudio, #battery, #tray {
        background: ${base01};
        padding: 0 8px;
        margin: 4px 3px 0;
        border-radius: 10px;
      }

      #workspaces { padding: 0 6px; }
      #workspaces button {
        padding: 0;
        margin: 6px 4px;
        min-width: 14px;
        min-height: 14px;
        border-radius: 50%;
        color: transparent;
        background: ${base03};
      }
      #workspaces button.active  { background: ${base0D}; }
      #workspaces button.urgent  { background: ${base08}; }
      #workspaces button:hover   { background: ${base05}; }

      #clock      { color: ${base0A}; }
      #cpu        { color: ${base0B}; }
      #memory     { color: ${base0C}; }
      #network    { color: ${base0D}; }
      #bluetooth  { color: ${base0D}; }
      #pulseaudio { color: ${base09}; }
      #battery    { color: ${base0E}; }

      #battery.warning  { color: ${base0A}; }
      #battery.critical { color: ${base08}; }
      #battery.charging { color: ${base0B}; }

      #pulseaudio.muted     { color: ${base03}; }
      #bluetooth.disabled,
      #bluetooth.off        { color: ${base03}; }
    '';
  };
}
