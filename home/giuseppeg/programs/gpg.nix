{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSshSupport = true;
    defaultCacheTtl = 3600;
    maxCacheTtl = 86400;
  };
}
