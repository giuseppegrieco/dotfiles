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
      wallpaper = [
        "eDP-1,${wallpaper}"
        ",${wallpaper}"
      ];
    };
  };
}
