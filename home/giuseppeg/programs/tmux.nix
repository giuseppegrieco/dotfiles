{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    secureSocket = false;

    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
    ];

    extraConfig = "";
  };
}
