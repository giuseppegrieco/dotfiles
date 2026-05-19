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
        color: @text;
      }

      #workspaces {
        margin: 0 10px;
        background: transparent;
      }

      #workspaces button {
        color: @surface2;
        border-bottom: 3px solid transparent;
        background: transparent;
      }

      #workspaces button.active {
        color: @blue;
        background: transparent;
        border-bottom: 3px solid @blue;
      }

      #workspaces button:hover {
        color: @text;
        background: alpha(@surface0, 0.5);
      }

      #clock, #cpu, #memory, #network, #battery, #tray {
        margin: 0 5px;
        background: transparent;
      }

      #cpu {
        color: @teal;
        border-bottom: 3px solid @teal;
      }

      #memory {
        color: @mauve;
        border-bottom: 3px solid @mauve;
      }

      #network {
        color: @sapphire;
        border-bottom: 3px solid @sapphire;
      }

      #battery {
        color: @green;
        border-bottom: 3px solid @green;
      }

      #clock {
        color: @blue;
        border-bottom: 3px solid @blue;
        margin-bottom: 4px;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }
    '';
  };
}
