{ config, pkgs, ... }:

{
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

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
    ./programs/firefox.nix
    ./programs/hyprland.nix
    ./programs/kitty.nix
    ./programs/rofi.nix
    ./programs/ssh.nix
    ./programs/starship.nix
    ./programs/vscode.nix
    ./programs/waybar.nix
    ./programs/zsh.nix
  ];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    BROWSER = "${pkgs.firefox}/bin/firefox";
    NIXOS_OZONE_WL = "1";
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
    neovim
    bat

    nerd-fonts.jetbrains-mono
    nixfmt
    nixd
    libnotify

    gimp
    libreoffice-fresh

    valgrind
    strace
    ltrace
    gdb
    clang-tools

    fzf
    ripgrep
    fd
    btop
    nmap

    nautilus
    pavucontrol
    pamixer
    polkit_gnome

    grim
    slurp
    swappy
    wl-clipboard

    python3
    go
    gopls
    delve
    gcc
    gnumake

    terraform
    kubernetes-helm
    kubectl
    jq
    k9s
    docker-compose

    catppuccin-cursors.mochaMauve

    opencode
  ];

  home.stateVersion = "25.11";
}
