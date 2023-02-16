{ pkgs, ... }:

{
  programs.git = with pkgs; {
    enable = true;
    package = gitAndTools.gitFull;
    userEmail = "paroxp@gmail.com";
    userName = "Rafal Proszowski";
    signing.key = "0xC4CE726F8465B7FC";
    signing.signByDefault = true;

    extraConfig = {
      core = { whitespace = "trailing-space,space-before-tab"; editor = "vim"; };
      color = { ui = "auto"; };
      pull = { rebase = "true"; };
      push = { default = "tracking"; };
      rebase = { autoSquash = "true"; };
      rerere = { enabled = "false"; };
      github = { user = "paroxp"; };
    };

    aliases = {
      branch = "branch -ra";
      ca = "commit --amend";
      caa = "commit -a --amend -C HEAD";
      co = "checkout";
      diff = "diff --word-diff";
      grep = "grep -Ii";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --numstat";
      ls = "log --pretty=format:\"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=relative";
      pushf = "push --force-with-lease";
      status = "status -s";
    };

    ignores = [
      "*~"
      "*.DS_Store"
      "shell.nix"
    ];
  };
}
