{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    setOptions = [
      "AUTOCD"
      "GLOB_DOTS"
    ];

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixos";
      ncg = "nix-collect-garbage -d";

      ls = "ls --color=auto --group-directories-first";
      ll = "ls -lh --color=auto --group-directories-first";
    };
  };
}
