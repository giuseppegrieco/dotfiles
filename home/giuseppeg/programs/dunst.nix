{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 350;
        height = 300;
        origin = "top-right";
        offset = "10x10";

        frame_width = 2;
        corner_radius = 0;
        padding = 8;
        horizontal_padding = 12;
        text_icon_padding = 10;
        gap_size = 6;

        format = "<b>%s</b>\n%b";
        transparency = 10;
        notification_limit = 5;

        icon_position = "left";
        max_icon_size = 48;

        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
      };

      urgency_low = {
        timeout = 3;
      };
      urgency_normal = {
        timeout = 5;
      };
      urgency_critical = {
        timeout = 0;
      };
    };
  };
}
