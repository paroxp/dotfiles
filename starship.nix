{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      format = pkgs.lib.concatStrings [
        "$cmd_duration"
        "$username"
        "$hostname"
        "$\{custom.root\}"
        "$\{custom.user\}"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$line_break"
        "$\{custom.greet\}"
        "$character"
      ];

      cmd_duration = {
        format = "took [$duration]($style)\n";
      };

      username = {
        format = "[$user]($style)";
        style_user = "yellow";
      };

      hostname = {
        format = "[@$hostname]($style) ";
        style = "green";
      };

      directory = {
        truncate_to_repo = false;
        truncation_symbol = "../";
        style = "bold yellow";
      };

      git_branch = {
        format = "on git:[$branch(:remote_branch)]($style) ";
        style = "bold blue";
      };

      git_commit = {
        format = "on git:[$hash$tag]($style) ";
        style = "bold blue";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold";

        conflicted = "[=](bright-red)";
        ahead = "[⇡ $\{count\}](blue)";
        behind = "[⇣ $\{count\}](red)";
        diverged = "[⇕]( [$\{ahead_count\}](blue)/[$\{behind_count\}](red)";
        untracked = "[?](red)";
        stashed = "[$](purple)";
        modified = "[!](bright-red)";
        staged = "[+](dimmed green)";
        renamed = "[»](dimmed blue)";
        deleted = "[✘](dimmed red)";
      };

      custom = {
        greet = {
          command = "echo $GREET";
          format = "[\\($output\\)]($style) ";
          style = "yellow";
          when = "test \"$GREET\" != \"\"";
        };

        root = {
          format = "[$symbol]($style) ";
          style = "bold red";
          symbol = "#";
          when = "test \"$USER\" = \"root\"";
        };

        user = {
          format = "[$symbol]($style) ";
          style = "bold blue";
          symbol = "\\$";
          when = "test \"$USER\" != \"root\"";
        };
      };

      character = {
        success_symbol = "[→](bold green)";
        error_symbol = "[→](bold red)";
      };
    };
  };
}
