{ config, pkgs, ... }:

let
  savePath = "~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png";
  latest = "$(ls -t ~/Pictures/Screenshots/screenshot_*.png 2>/dev/null | head -1)";

  takeFull = "grim ${savePath} && notify-send 'Screenshot saved' 'Full screen captured'";
  takeArea = "grim -g \"$(slurp)\" ${savePath} && notify-send 'Screenshot saved' 'Region captured'";
  editShot = "swappy -f ${latest}";
  copyShot = "wl-copy < ${latest} && notify-send 'Screenshot copied' 'Copied to clipboard'";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    settings = {
      "exec-once" = [
        "waybar"
      ];
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -show-icons";

      env = [
        "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "XCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "$lavender $sapphire 45deg";
        "col.inactive_border" = "$surface0";
        layout = "dwindle";
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      animations = {
        enabled = false;
      };

      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"
        "6, persistent:true"
      ];

      bind = [
        "$mod, Q, exec, $terminal"
        "$mod, SPACE, exec, $menu"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, LEFT, movefocus, l"
        "$mod, RIGHT, movefocus, r"
        "$mod, UP, movefocus, u"
        "$mod, DOWN, movefocus, d"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        "$mod SHIFT, LEFT, movewindow, l"
        "$mod SHIFT, RIGHT, movewindow, r"
        "$mod SHIFT, UP, movewindow, u"
        "$mod SHIFT, DOWN, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"

        "$mod, PRINT, exec, ${takeFull}"
        "$mod SHIFT, PRINT, exec, ${takeArea}"
        "$mod SHIFT, E, exec, ${editShot}"
        "$mod ALT, E, exec, ${copyShot}"

        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"

        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod SHIFT, M, exit"
        "$mod, C, killactive"
      ];
    };
  };
}
