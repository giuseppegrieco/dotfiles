{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [ ];

    plugins = with pkgs.vimPlugins; [ mini-nvim ];

    initLua = ''
      require("config.options")
      require("config.remap")
      require("config.lazy")
    '';
  };

  xdg.configFile."nvim/lua".source = ./nvim;
}
