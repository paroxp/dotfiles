{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "editor.rulers" = [80 120];
      "files.autoSave" = "onFocusChange";
      "workbench.colorTheme" = "Default Dark+";
      "cSpell.language" = "en-GB";
      "cSpell.enableFiletypes" = [
        "ruby"
      ];
    };

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dbaeumer.vscode-eslint
      denoland.vscode-deno
      eamodio.gitlens
      editorconfig.editorconfig
      golang.go
      hashicorp.terraform
      matklad.rust-analyzer
      streetsidesoftware.code-spell-checker
    ];
  };
}
