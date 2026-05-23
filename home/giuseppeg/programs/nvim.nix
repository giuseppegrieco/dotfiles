{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withRuby = false;
    withPython3 = false;

    initLua = ''
      vim.g.parinfer_dylib_path = "${pkgs.parinfer-rust}/lib/libparinfer_rust.so"
      require("config.options")
      require("config.remap")
      require("config.lazy")
    '';
  };

  xdg.configFile."nvim/lua".source = ./nvim;
}
