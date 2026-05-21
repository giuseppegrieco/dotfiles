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
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#\$(hostname)";
      ncg = "nix-collect-garbage -d";

      ls = "ls --color=auto --group-directories-first";
      ll = "yazi";

      snvim = "SUDO_EDITOR=\$(which nvim) sudoedit";
      spush = "sudo GIT_SSH_COMMAND='ssh -i /home/giuseppeg/.ssh/id_ed25519_github -o IdentitiesOnly=yes' git push";
      spull = "sudo GIT_SSH_COMMAND='ssh -i /home/giuseppeg/.ssh/id_ed25519_github -o IdentitiesOnly=yes' git pull";
    };
  };
}
