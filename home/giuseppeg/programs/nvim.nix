{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [];
  };

  # xdf.configFile."nvim".source = ./nvim;
}
