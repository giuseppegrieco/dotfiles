{ pkgs, ... }:

let
  wallpaper = ../wallpaper.jpg;
in
{
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    splash = false

    wallpaper {
        monitor = eDP-1
        path = ${wallpaper}
    }

    wallpaper {
        monitor =
        path = ${wallpaper}
    }
  '';
}
