{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "editor.rulers" = [80 120];
        "files.autoSave" = "onFocusChange";
        "workbench.colorTheme" = "Default Dark+";
        "cSpell.language" = "en-GB";
        "cSpell.enableFiletypes" = [
          "ruby"
        ];
        "window.menuBarVisibility" = "toggle";
      };

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        eamodio.gitlens
        editorconfig.editorconfig
        golang.go
        hashicorp.terraform
        rust-lang.rust-analyzer
        streetsidesoftware.code-spell-checker
      ];
    };
  };
}
