{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    font = "JetBrainsMono Nerd Font";

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
