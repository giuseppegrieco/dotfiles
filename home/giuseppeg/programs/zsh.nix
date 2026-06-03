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
      nix-clean = "sudo nix-collect-garbage -d --delete-older-than 14d && sudo nix store optimise";
      nix-audit = "nix shell nixpkgs#vulnix -c vulnix --system";

      ls = "ls --color=auto --group-directories-first";
      ll = "yazi";

      snvim = "SUDO_EDITOR=\$(which nvim) sudoedit";
      spush = "sudo GIT_SSH_COMMAND='ssh -i /home/giuseppeg/.ssh/id_ed25519_github -o IdentitiesOnly=yes' git push";
      spull = "sudo GIT_SSH_COMMAND='ssh -i /home/giuseppeg/.ssh/id_ed25519_github -o IdentitiesOnly=yes' git pull";

      k3s-start = "sudo systemctl start k3s";
      k3s-stop = "sudo systemctl stop k3s";
      k3s-restart = "sudo systemctl restart k3s";
    };

    initContent = ''
      # Wipe all k3s cluster state and restart the service.
      # Deletes /var/lib/rancher/k3s (workloads, PVs, secrets, etcd) — prompts first.
      k3s-reset() {
        print -r -- "This will DELETE all k3s cluster state (pods, PVs, secrets)."
        print -rn -- "Continue? [y/N] "
        local reply
        read -r reply
        [[ "$reply" == [yY]* ]] || { print -r -- "Aborted."; return 1; }
        sudo systemctl stop k3s \
          && sudo k3s-killall.sh \
          && sudo rm -rf /var/lib/rancher/k3s \
          && sudo systemctl start k3s \
          && print -r -- "k3s reset; cluster state cleared."
      }
    '';
  };
}
