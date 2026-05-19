{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      ExtensionSettings = {
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/search_by_image/latest.xpi";
          installation_mode = "force_installed";
        };
        "{ddc62400-f22d-4dd3-8b4a-05837de53c2e}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/read-aloud/latest.xpi";
          installation_mode = "force_installed";
        };
        "FirefoxColor@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.giuseppeg = {
      isDefault = true;

      settings = {
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.position_start" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;"
        layout.css.prefers-color-scheme.content-override" = 2; 
        "ui.systemUsesDarkTheme" = 1;
      };

      extensions = {
        force = true;
      };
    };
  };
}
