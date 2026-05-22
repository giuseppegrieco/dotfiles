{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors.withHashtag;
  # Glyph painted in the bar-bg colour; the coloured block behind it is the
  # module's own background (set in CSS) so it fills the pill and follows its radius.
  badge = icon: "<span foreground='${c.base00}'> ${icon} </span>";
in
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
          format = "";
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
          format = "${badge "󰻠"} {usage}%";
          tooltip = false;
          on-click = "kitty --class float-btop -e btop";
        };

        memory = {
          format = "${badge "󰍛"} {percentage}%";
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
          format-wifi = "${badge "󰖩"} {essid}";
          format-ethernet = "${badge "󰈀"} Ethernet";
          format-linked = "${badge "󰈀"} (No IP)";
          format-disconnected = "${badge "󰖪"} Disconnected";
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
          format = "${badge "{icon}"} {volume}%";
          "format-muted" = "${badge "󰝟"} muted";
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
        /* Inter for text, JetBrainsMono Nerd Font as fallback for icon glyphs. */
        font-family: "${config.stylix.fonts.sansSerif.name}", "${config.stylix.fonts.monospace.name}";
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        /* base00 fill + red-to-yellow gradient ring; padding-box/border-box
           keeps the gradient as a border that still respects border-radius. */
        background:
          linear-gradient(${base00}, ${base00}) padding-box,
          linear-gradient(45deg, ${base08}, ${base0A}) border-box;
        color: ${base05};
        border: 2px solid transparent;
        border-radius: 12px;
      }

      /* Inset the leftmost/rightmost modules from the bar's rounded edges. */
      .modules-left  { margin-left: 4px; }
      .modules-right { margin-right: 4px; }

      #clock,
      #mpris,
      #cpu, #memory, #pulseaudio, #battery, #tray, #status {
        background: ${base01};
        padding: 0 6px;
        margin: 8px 4px;
        border: 2px solid ${base01};
        border-radius: 10px;
      }

      /* Workspaces group = one pill holding the NixOS logo block + the dots. */
      #ws {
        background: ${base01};
        margin: 8px 4px;
        border: 2px solid ${base0D};
        border-radius: 10px;
      }
      #ws #workspaces { background: transparent; border: none; margin: 0; padding: 0 6px; }
      /* Logo block: cyan fill, glyph in bar-bg, left corners rounded to the pill. */
      #custom-logo {
        background: ${base0D};
        color: ${base00};
        padding: 0 11px 0 7px;
        border-radius: 8px 0 0 8px;
      }

      #workspaces button {
        padding: 0;
        margin: 4px 4px;
        min-width: 16px;
        min-height: 16px;
        border-radius: 50%;
        color: transparent;
        background: ${base03};
      }
      #workspaces button.active  { background: ${base0D}; }
      #workspaces button.urgent  { background: ${base08}; }
      #workspaces button:hover   { background: ${base05}; }

      /* No pill behind the clock — just the text. */
      #clock { color: ${base0A}; background: transparent; border-color: transparent; }

      /* Hard-stop gradient: left ~1.9em is the accent icon block (flush to the
         pill's top/left/bottom and clipped to its radius), the rest is base01. */
      #cpu {
        color: ${base0B}; border-color: ${base0B}; padding-left: 0;
        background-image: linear-gradient(to right, ${base0B} 1.9em, ${base01} 1.9em);
      }
      #memory {
        color: ${base0C}; border-color: ${base0C}; padding-left: 0;
        background-image: linear-gradient(to right, ${base0C} 1.9em, ${base01} 1.9em);
      }
      #pulseaudio {
        color: ${base09}; border-color: ${base09}; padding-left: 0;
        background-image: linear-gradient(to right, ${base09} 1.9em, ${base01} 1.9em);
      }
      #bluetooth  { color: ${base0D}; border-color: ${base0D}; }
      #battery    { color: ${base0E}; border-color: ${base0E}; }

      #battery.warning  { color: ${base0A}; border-color: ${base0A}; }
      #battery.critical { color: ${base08}; border-color: ${base08}; }
      #battery.charging { color: ${base0B}; border-color: ${base0B}; }

      #pulseaudio.muted     { color: ${base03}; border-color: ${base03}; }
      #bluetooth.disabled,
      #bluetooth.off        { color: ${base03}; border-color: ${base03}; }

      #mpris          { color: ${base05}; border-color: ${base05}; }
      #idle_inhibitor { color: ${base0A}; border-color: ${base0A}; }
      #idle_inhibitor.activated { color: ${base0B}; border-color: ${base0B}; }

      #bluetooth, #idle_inhibitor, #mpris {
        transition: background-color 0.2s ease, color 0.2s ease;
      }
      #bluetooth:hover, #idle_inhibitor:hover, #mpris:hover {
        background: ${base02};
      }

      /* Status group: network keeps its left accent block (rounded to the
         pill), bluetooth + keep-awake sit to its right as plain icons. */
      #status { padding-left: 0; }
      #status #network {
        color: ${base0D};
        padding: 0 8px 0 0;
        border-radius: 8px 0 0 8px;
        background-image: linear-gradient(to right, ${base0D} 1.9em, ${base01} 1.9em);
      }
      #status #bluetooth,
      #status #idle_inhibitor { padding: 0 8px; }
    '';
  };
}
