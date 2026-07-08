{ config, pkgs, ... }:

let
  prettierLangs = [
    "javascript"
    "javascriptreact"
    "typescript"
    "typescriptreact"
    "json"
    "jsonc"
    "yaml"
    "markdown"
    "css"
    "html"
  ];
  prettierFor = builtins.listToAttrs (
    map (lang: {
      name = "[${lang}]";
      value = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
      };
    }) prettierLangs
  );
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        sumneko.lua
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        twxs.cmake
        ms-vscode.cmake-tools
        mads-hartmann.bash-ide-vscode
        dbaeumer.vscode-eslint
        redhat.vscode-yaml
        tamasfe.even-better-toml
        rust-lang.rust-analyzer
        golang.go
        detachhead.basedpyright
        charliermarsh.ruff
        ms-python.python
        elixir-lsp.vscode-elixir-ls

        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-java-test
        vscjava.vscode-maven
        vscjava.vscode-gradle
        vscjava.vscode-java-dependency

        mathiasfrohlich.kotlin

        esbenp.prettier-vscode
        foxundermoon.shell-format

        vadimcn.vscode-lldb
        ms-python.debugpy

        vscodevim.vim

        supermaven.supermaven
      ];

      userSettings = {
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings"."nixd"."formatting"."command" = [ "nixfmt" ];
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";

        "clangd.path" = "clangd";
        "clangd.arguments" = [ "--query-driver=/nix/store/*/bin/*" ];
        "[c]"."editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
        "[cpp]"."editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";

        "python.languageServer" = "None";
        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
          "editor.formatOnSave" = true;
          "editor.codeActionsOnSave" = {
            "source.organizeImports.ruff" = "explicit";
            "source.fixAll.ruff" = "explicit";
          };
        };

        "go.formatTool" = "gofmt";
        "[go]"."editor.formatOnSave" = true;

        "java.jdt.ls.java.home" = pkgs.jdk.home;
        "java.configuration.runtimes" = [
          {
            name = "JavaSE-21";
            path = pkgs.jdk.home;
            default = true;
          }
        ];
        "java.import.gradle.java.home" = pkgs.jdk.home;
        "redhat.telemetry.enabled" = false;
        "[java]" = {
          "editor.defaultFormatter" = "redhat.java";
          "editor.formatOnSave" = true;
        };

        "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";

        "[shellscript]"."editor.defaultFormatter" = "foxundermoon.shell-format";

        "eslint.run" = "onType";
        "[javascript]"."editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
        "[javascriptreact]"."editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
        "[typescript]"."editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
        "[typescriptreact]"."editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";

        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
      }
      // prettierFor;
    };
  };
}
