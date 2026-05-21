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

        # Borders, padding, & gaps
        frame_width = 2;
        corner_radius = 0;
        padding = 8;
        horizontal_padding = 12;
        text_icon_padding = 10;
        gap_size = 6;

        # Typography & layout (font is set globally by Stylix)
        format = "<b>%s</b>\n%b";
        transparency = 10;
        notification_limit = 5;

        # Icon handling
        icon_position = "left";
        max_icon_size = 48;

        # Progress bar settings (perfect for volume/brightness indicators!)
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
