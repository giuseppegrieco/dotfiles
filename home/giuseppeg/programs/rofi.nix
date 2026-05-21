{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
    };
  };
}
