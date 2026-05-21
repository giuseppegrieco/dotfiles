{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      # Colors come from Stylix's hyprlock target; we only set layout here.
      background = [
        {
          blur_passes = 3;
          blur_size = 8;
          noise = 1.0e-2;
        }
      ];

      input-field = [
        {
          size = "300, 50";
          position = "0, -80";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          rounding = 0;
          placeholder_text = "<i>Password...</i>";
          fade_on_empty = false;
        }
      ];

      label = [
        # Clock
        {
          text = "$TIME";
          font_size = 64;
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
        # User greeting
        {
          text = "Hi, $USER";
          font_size = 20;
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
