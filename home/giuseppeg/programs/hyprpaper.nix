{ ... }:

let
  wallpaper = ../wallpaper.png;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "${wallpaper}" ];
      # "," = apply to all monitors.
      wallpaper = [ ",${wallpaper}" ];
    };
  };
}
