{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = "$directory$git_branch$git_status$nix_shell$character";

      directory = {
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = " ";
      };

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol\\($name\\)]($style) ";
      };

      character = {
        success_symbol = " [❯](bold green) ";
        error_symbol = " [❯](bold red) ";
      };
    };
  };
}
