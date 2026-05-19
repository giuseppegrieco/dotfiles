{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Giuseppe Grieco";
    userEmail = "g.grieco1997@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      fetch.prune = true;
      core.editor = "nvim";
      push.autoSetupRemote = true;
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit -m";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };
  };
}
