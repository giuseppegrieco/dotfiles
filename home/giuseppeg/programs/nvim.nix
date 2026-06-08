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

  # Global clangd config so loose .cpp files (no compile_commands.json) resolve
  # the stdlib. On NixOS clangd can't find GCC's headers on its own; telling it
  # to use g++ as the driver makes it query the wrapper for libstdc++ includes
  # (e.g. <bits/stdc++.h>). Paired with --query-driver in plugins/lsp.lua.
  xdg.configFile."clangd/config.yaml".text = ''
    CompileFlags:
      Compiler: ${pkgs.gcc}/bin/g++
      Add:
        - -std=c++23
  '';
}
