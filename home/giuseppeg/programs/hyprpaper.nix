{ ... }:

let
  wallpaper = ../wallpaper.jpg;
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
