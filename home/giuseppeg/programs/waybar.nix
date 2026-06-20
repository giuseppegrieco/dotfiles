{ config, pkgs, lib, ... }:

let
  # The Anker PowerConf C200 has no motor; "FOV" is just the UVC zoom_absolute
  # control (100 = widest .. 400 = tightest). We expose three presets, derived
  # from the camera's native ~95° at zoom 100:
  #   FOV 95° -> zoom 100  (native, widest)
  #   FOV 78° -> zoom 135  (mid)
  #   FOV 65° -> zoom 171  (tightest of the three; good for "just my face")
  # Tweak these zoom numbers to taste — the FOV labels are nominal.
  cameraDev = "/dev/v4l/by-id/usb-Anker_PowerConf_C200_*-video-index0";
  binPath = lib.makeBinPath [
    pkgs.v4l-utils
    config.wayland.windowManager.hyprland.package
    pkgs.jq
    pkgs.libnotify
    pkgs.coreutils
    pkgs.gawk
    pkgs.procps
  ];

  # Emits waybar JSON. Empty text when the camera is unplugged -> module hides.
  cameraStatus = pkgs.writeShellScript "waybar-camera-status" ''
    export PATH=${binPath}:$PATH
    set -uo pipefail
    dev=$(ls ${cameraDev} 2>/dev/null | head -n1 || true)
    if [ -z "$dev" ]; then
      echo '{"text":"","tooltip":""}'
      exit 0
    fi
    zoom=$(v4l2-ctl -d "$dev" --get-ctrl=zoom_absolute 2>/dev/null | awk -F': ' '{print $2}')
    zoom=''${zoom:-100}
    if   [ "$zoom" -ge 153 ]; then fov=65
    elif [ "$zoom" -ge 118 ]; then fov=78
    else                           fov=95
    fi
    printf '{"text":"FOV: %s°","tooltip":"Anker C200 — FOV %s° (zoom %s) • click to cycle 95/78/65","class":"fov%s"}\n' "$fov" "$fov" "$zoom" "$fov"
  '';

  # Narrows the FOV on each click, wrapping back to widest. Then nudges waybar
  # (SIGRTMIN+8) so the label updates instantly instead of waiting for the poll.
  cameraToggle = pkgs.writeShellScript "waybar-camera-toggle" ''
    export PATH=${binPath}:$PATH
    set -uo pipefail
    dev=$(ls ${cameraDev} 2>/dev/null | head -n1 || true)
    [ -z "$dev" ] && exit 0
    zoom=$(v4l2-ctl -d "$dev" --get-ctrl=zoom_absolute 2>/dev/null | awk -F': ' '{print $2}')
    zoom=''${zoom:-100}
    if   [ "$zoom" -ge 153 ]; then next=100   # 65 -> 95
    elif [ "$zoom" -ge 118 ]; then next=171   # 78 -> 65
    else                           next=135   # 95 -> 78
    fi
    v4l2-ctl -d "$dev" --set-ctrl=zoom_absolute="$next"
    pkill -RTMIN+8 waybar || true
  '';

  # Monitor mirror toggle. The external is resolved dynamically as whatever is
  # physically connected besides the built-in eDP-1 panel (any port: DP, HDMI,
  # dock). "mirror" = laptop is the source and the external duplicates it;
  # "external" = external alone at its native res with the laptop panel off
  # (the laptop can't mirror a higher-res external, so we turn it off rather
  # than mirror the other way). Hidden when no external is connected.
  monitorStatus = pkgs.writeShellScript "waybar-monitor-status" ''
    export PATH=${binPath}:$PATH
    set -uo pipefail
    mons=$(hyprctl monitors all -j 2>/dev/null) || { echo '{"text":"","tooltip":""}'; exit 0; }
    ext=$(printf '%s' "$mons" | jq -r '[.[] | select(.name!="eDP-1")][0].name // empty')
    if [ -z "$ext" ]; then
      echo '{"text":"","tooltip":""}'
      exit 0
    fi
    off=$(printf '%s' "$mons" | jq -r '.[] | select(.name=="eDP-1") | .disabled')
    if [ "$off" = "true" ]; then
      printf '{"text":"DISP: external","tooltip":"%s only, laptop off • click to mirror","class":"external"}\n' "$ext"
    else
      printf '{"text":"DISP: mirror","tooltip":"Mirrored to %s (laptop is main) • click for external-only","class":"mirror"}\n' "$ext"
    fi
  '';

  # Toggles the two states, then refreshes the bar (SIGRTMIN+9). NB: re-enabling
  # eDP-1 and attaching the mirror in a single `hyprctl --batch` silently leaves
  # eDP-1 asleep (verified Hyprland quirk for a software disable -> enable, with
  # no hardware reconnect event). So each direction uses separate commands, in a
  # safe order, and the wake path waits until eDP-1 is actually on first.
  monitorToggle = pkgs.writeShellScript "waybar-monitor-toggle" ''
    export PATH=${binPath}:$PATH
    set -uo pipefail
    mons=$(hyprctl monitors all -j 2>/dev/null) || exit 0
    ext=$(printf '%s' "$mons" | jq -r '[.[] | select(.name!="eDP-1")][0].name // empty')
    [ -z "$ext" ] && { notify-send "Display" "No external monitor connected"; exit 0; }
    off=$(printf '%s' "$mons" | jq -r '.[] | select(.name=="eDP-1") | .disabled')
    if [ "$off" = "true" ]; then
      # external-only -> mirror: wake the laptop first, wait until it is really
      # on, then point the external's mirror at it.
      hyprctl keyword monitor "eDP-1,preferred,auto,1.25"
      for _ in $(seq 10); do
        [ "$(hyprctl monitors all -j | jq -r '.[]|select(.name=="eDP-1")|.disabled')" = "false" ] && break
        sleep 0.1
      done
      hyprctl keyword monitor "$ext,preferred,auto,1,mirror,eDP-1"
    else
      # mirror -> external-only: stop the external mirroring first, then turn
      # the laptop panel off (never disable a monitor still being mirrored).
      hyprctl keyword monitor "$ext,preferred,auto,1"
      hyprctl keyword monitor "eDP-1,disable"
    fi
    pkill -RTMIN+9 waybar || true
  '';
in
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
          "custom/camera"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "custom/monitor"
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

        "custom/camera" = {
          exec = "${cameraStatus}";
          return-type = "json";
          interval = 3;
          signal = 8;
          format = "{}";
          on-click = "${cameraToggle}";
          tooltip = true;
        };

        "custom/monitor" = {
          exec = "${monitorStatus}";
          return-type = "json";
          interval = 2;
          signal = 9;
          format = "{}";
          on-click = "${monitorToggle}";
          tooltip = true;
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
      #custom-camera,
      #custom-monitor,
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
      #workspaces button.active { background-color: ${base01}; color: ${base08}; }
      #workspaces button:hover  { background-color: ${base02}; color: ${base00}; }
      #workspaces button.urgent { background-color: ${base08}; color: ${base00}; }

      #clock { color: ${base0A}; }
      #network { color: ${base0B}; }
      #pulseaudio { color: ${base0D}; }
      #cpu { color: ${base0E}; }
      #memory { color: ${base09}; }
      #bluetooth { color: ${base0C}; }
      #idle_inhibitor { color: ${base0D}; }

      /* camera FOV: green (wide) -> yellow (mid) -> orange (tight) */
      #custom-camera { color: ${base0C}; }
      #custom-camera.fov95 { color: ${base0B}; }
      #custom-camera.fov78 { color: ${base0A}; }
      #custom-camera.fov65 { color: ${base09}; }

      /* display: mirror (magenta) vs external-only / laptop off (orange) */
      #custom-monitor { color: ${base0E}; }
      #custom-monitor.mirror   { color: ${base0E}; }
      #custom-monitor.external { color: ${base09}; }

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
