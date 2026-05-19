{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-vscode.makefile-tools
        redhat.vscode-yaml
        eamodio.gitlens
        vscodevim.vim
        golang.go
      ];

      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.fontLigatures" = true;

        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;

        "workbench.startupEditor" = "none";
        "workbench.welcomePage.walkthroughs.openOnCommandsPage" = false;
        "workbench.sideBar.visible" = true;
        "workbench.sideBar.location" = "right";
        "workbench.activityBar.location" = "default";
        "workbench.view.extension.copilot" = "hidden";
        "workbench.activityBar.hiddenItems" = {
          "workbench.view.extension.makefile" = true;
          "workbench.view.extension.gitlens" = true;
        };

        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "modifications";
        "editor.defaultFormatter" = null;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };

        "go.useLanguageServer" = true;
        "go.formatTool" = "gofmt";
        "[go]" = {
          "editor.formatOnSave" = true;
          "editor.codeActionsOnSave" = {
            "source.organizeImports" = "explicit";
          };
        };

        "yaml.format.enable" = true;
        "[yaml]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
          "editor.tabSize" = 2;
        };

        "vim.useSystemClipboard" = true;

        "gitlens.currentLine.enabled" = true;
        "gitlens.codeLens.enabled" = false;
      };
    };
  };
}
