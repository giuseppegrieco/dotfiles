{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts =
      let
        jetbrains = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        inter = {
          package = pkgs.inter;
          name = "Inter";
        };
        notoSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
      in
      {
        monospace = jetbrains;
        sansSerif = inter;
        serif = notoSerif;
      };

    # Firefox theming needs the profile name declared explicitly.
    targets.firefox.profileNames = [ "giuseppeg" ];

    targets.waybar.enable = false;
    overlays.enable = false;
  };

  gtk.gtk4.theme = config.gtk.theme;

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
    ./programs/hyprlock.nix
    ./programs/firefox.nix
    ./programs/hyprland.nix
    ./programs/hyprpaper.nix
    ./programs/kitty.nix
    ./programs/nvim.nix
    ./programs/rofi.nix
    ./programs/ssh.nix
    ./programs/starship.nix
    ./programs/swayosd.nix
    ./programs/tmux.nix
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
    rnote
    discord
    slack
    obs-studio

    valgrind
    strace
    ltrace
    gdb
    clang-tools

    yazi
    bat
    fzf
    ripgrep
    fd
    btop
    nmap
    fastfetch
    gh
    jq
    yq

    pavucontrol
    pamixer
    blueman
    playerctl
    spotify-player
    brightnessctl

    grim
    slurp
    swappy
    wl-clipboard

    gcc
    cmake
    pkg-config

    rustc
    cargo
    rustfmt
    clippy
    go
    golangci-lint
    nodejs
    pnpm
    python3
    uv
    poetry
    elixir

    lua-language-server
    bash-language-server
    vscode-langservers-extracted
    typescript-language-server
    yaml-language-server
    taplo
    rust-analyzer
    gopls
    basedpyright
    marksman
    elixir-ls

    stylua
    prettierd
    shfmt
    ruff

    gnumake
    parinfer-rust
    vscode-extensions.vadimcn.vscode-lldb
    delve
    python3Packages.debugpy

    opencode
  ];

  home.stateVersion = "25.11";
}
