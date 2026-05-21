{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };

    # Style for Hyprland borders/cursor and the Waybar CSS are created
    # referencing the generated palette via config.lib.stylix.colors.
    targets.hyprland.enable = false;
    targets.waybar.enable = false;
  };

  home.username = "giuseppeg";
  home.homeDirectory = "/home/giuseppeg";
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };
  home.file."Pictures/Screenshots/.keep".text = "";

  imports = [
    ./programs/direnv.nix
    ./programs/dunst.nix
    ./programs/git.nix
    ./programs/firefox.nix
    ./programs/hyprland.nix
    ./programs/kitty.nix
    ./programs/nvim.nix
    ./programs/rofi.nix
    ./programs/ssh.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/vscode.nix
    ./programs/waybar.nix
    ./programs/zsh.nix
  ];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    BROWSER = "${pkgs.firefox}/bin/firefox";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      "application/pdf" = [ "firefox.desktop" ];
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    hyprpolkitagent
    nixfmt
    nixd
    libnotify

    gimp

#    valgrind
#    strace
#    ltrace
#    gdb
#    clang-tools

    yazi
    bat
    fzf
    ripgrep
    fd
    btop
    nmap

#    nautilus
#    pavucontrol
#    pamixer
#    polkit_gnome

    grim
    slurp
    swappy
    wl-clipboard

#    python3
#    go
#    gopls
#    delve
#    gcc
#    gnumake

#    terraform
#    kubernetes-helm
#    kubectl
#    jq
#    k9s
#    docker-compose

    opencode
  ];

  home.stateVersion = "25.11";
}
