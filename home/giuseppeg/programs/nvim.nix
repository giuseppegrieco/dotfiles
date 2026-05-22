{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [
      gcc # nvim-treesitter / native plugins compile at runtime
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
