{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        spacing = -2;
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        modules-left = [
          "hyprland/workspaces"
          "network"
          "bluetooth"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "idle_inhibitor"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          on-click = "activate";
          format = "{name}";
        };

        clock = {
          format = "{:%H:%M  |  %a, %d %b}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };

        cpu = {
          format = "CPU: {usage}%";
          # tooltip = false;
          on-click = "hyprctl dispatch exec 'kitty -e btop'";
        };

        memory = {
          format = "RAM: {percentage}%";
          on-click = "hyprctl dispatch exec 'kitty -e btop'";
        };

        network = {
          format-wifi = "NET: connected";
          format-ethernet = "NET: connected";
          format-linked = "NET: connected";
          format-disconnected = "NET: disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "hyprctl dispatch exec 'kitty -e nmtui'";
        };

        pulseaudio = {
          format = "VOL: {volume}%";
          "format-muted" = "VOL: muted";
          "scroll-step" = 5;
          on-click = "pamixer -t";
          "on-click-right" = "hyprctl dispatch exec 'pavucontrol'";
          "tooltip-format" = "{desc}  {volume}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "BAT: {capacity}%";
          "format-charging" = "BAT: {capacity}% +";
          "tooltip-format" = "{timeTo}";
        };

        bluetooth = {
          format = "BT: on";
          "format-disabled" = "BT: off";
          "format-off" = "BT: off";
          "format-connected" = "BT: on";
          on-click = "hyprctl dispatch exec 'kitty -e bluetuith'";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{device_enumerate}";
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "WAKE";
            deactivated = "AUTO";
          };
          "tooltip-format-activated" = "keep awake: on";
          "tooltip-format-deactivated" = "keep awake: off";
        };

        tray = {
          "icon-size" = 16;
          spacing = 8;
        };
      };
    };

    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 13px;
        font-weight: 500;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: ${base00};
        color: ${base05};
      }

      #workspaces,
      #clock,
      #network,
      #pulseaudio,
      #cpu,
      #memory,
      #battery,
      #bluetooth,
      #idle_inhibitor,
      #tray {
        background-color: ${base00};
        color: ${base05};
        border: 2px solid ${base01};
        padding: 0 6px;
        margin: 0;
      }

      #workspaces { padding: 0; }
      #workspaces button {
        color: ${base05};
        background-color: ${base00};
        padding: 0 8px;
        border-radius: 0;
        transition: background-color 120ms ease, color 120ms ease;
      }
      #workspaces button.active { background-color: ${base01}; color: ${base0A}; }
      #workspaces button:hover  { background-color: ${base02}; color: ${base00}; }
      #workspaces button.urgent { background-color: ${base08}; color: ${base00}; }

      #clock { color: ${base0A}; }
      #network { color: ${base0B}; }
      #pulseaudio { color: ${base0D}; }
      #cpu { color: ${base0E}; }
      #memory { color: ${base09}; }
      #bluetooth { color: ${base0C}; }
      #idle_inhibitor { color: ${base0D}; }

      #battery.warning  { color: ${base0A}; }
      #battery.critical { color: ${base08}; }
      #battery.charging { color: ${base0B}; }

      #pulseaudio.muted { color: ${base03}; }
      #bluetooth.disabled,
      #bluetooth.off    { color: ${base03}; }

      #idle_inhibitor.activated { color: ${base0B}; }
    '';
  };
}
