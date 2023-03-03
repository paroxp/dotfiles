{ pkgs, ... }:

let cfg = import ./config.nix; in {
  programs.git = with pkgs; {
    enable = true;
    package = gitAndTools.gitFull;
    userEmail = cfg.user.email;
    userName = cfg.user.fullName;
    signing.key = cfg.user.gpgID;
    signing.signByDefault = true;

    extraConfig = {
      color = { ui = "auto"; };
      core = { whitespace = "trailing-space,space-before-tab"; editor = "vim"; };
      github = { user = cfg.user.github; };
      init = { defaultBranch = "main"; };
      pull = { rebase = "true"; };
      push = { default = "tracking"; };
      rebase = { autoSquash = "true"; };
      rerere = { enabled = "false"; };
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
