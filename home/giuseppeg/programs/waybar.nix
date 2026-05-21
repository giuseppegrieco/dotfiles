{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors.withHashtag;
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "network"
          "battery"
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
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: ${c.base05};
      }

      #workspaces {
        margin: 0 10px;
        background: transparent;
      }

      #workspaces button {
        color: ${c.base03};
        border-bottom: 3px solid transparent;
        background: transparent;
      }

      #workspaces button.active {
        color: ${c.base0D};
        background: transparent;
        border-bottom: 3px solid ${c.base0D};
      }

      #workspaces button:hover {
        color: ${c.base05};
        background: alpha(${c.base02}, 0.5);
      }

      #clock, #cpu, #memory, #network, #battery, #tray {
        margin: 0 5px;
        background: transparent;
      }

      #cpu {
        color: ${c.base0C};
        border-bottom: 3px solid ${c.base0C};
      }

      #memory {
        color: ${c.base0E};
        border-bottom: 3px solid ${c.base0E};
      }

      #network {
        color: ${c.base0D};
        border-bottom: 3px solid ${c.base0D};
      }

      #battery {
        color: ${c.base0B};
        border-bottom: 3px solid ${c.base0B};
      }

      #clock {
        color: ${c.base0D};
        border-bottom: 3px solid ${c.base0D};
        margin-bottom: 4px;
      }

      #battery.charging {
        color: ${c.base0B};
      }

      #battery.warning:not(.charging) {
        color: ${c.base08};
      }
    '';
  };
}
