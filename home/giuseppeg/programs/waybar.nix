{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
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

      /* transparent bar so the modules float as pills */
      window#waybar {
        background: transparent;
        color: ${base05};
      }

      /* shared pill look */
      #workspaces,
      #clock,
      #cpu, #memory, #network, #bluetooth, #pulseaudio, #battery, #tray {
        background: ${base01};
        padding: 0 12px;
        margin: 4px 3px;
        border-radius: 10px;
      }

      /* workspaces as circles (no labels) */
      #workspaces { padding: 5px; }
      #workspaces button {
        width: 14px;
        height: 14px;
        border-radius: 50%;
        color: transparent;
        background: ${base03};
      }
      #workspaces button.active  { background: ${base0D}; }
      #workspaces button.urgent  { background: ${base08}; }
      #workspaces button:hover   { background: ${base05}; }

      /* center */
      #clock      { color: ${base0A}; }   /* yellow */

      /* right cluster — one accent each */
      #cpu        { color: ${base0B}; }   /* green  */
      #memory     { color: ${base0C}; }   /* aqua   */
      #network    { color: ${base0D}; }   /* blue   */
      #bluetooth  { color: ${base0D}; }   /* blue   */
      #pulseaudio { color: ${base09}; }   /* orange */
      #battery    { color: ${base0E}; }   /* purple */

      #battery.warning  { color: ${base0A}; }
      #battery.critical { color: ${base08}; }
      #battery.charging { color: ${base0B}; }

      #pulseaudio.muted     { color: ${base03}; }
      #bluetooth.disabled,
      #bluetooth.off        { color: ${base03}; }
    '';
  };
}
