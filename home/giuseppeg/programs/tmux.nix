{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    secureSocket = false;

    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;

    keyMode = "vi";

    historyLimit = 50000;

    sensibleOnTop = false;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Copy to the Wayland system clipboard in vi copy-mode
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
    '';
  };
}
