{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Giuseppe Grieco";
        email = "g.grieco1997@gmail.com";
      };

      signing = {
        signByDefault = true;
        key = "8EFBA187CF5F6515";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      fetch.prune = true;
      core.editor = "nvim";
      push.autoSetupRemote = true;

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit -m";
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
    };
  };
}
