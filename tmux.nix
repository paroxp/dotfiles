{ ... }:

{
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 50;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    reverseSplit = true;
    shortcut = "a";

    extraConfig = ''
      # Clear screen and buffer scroll
      bind -n C-k send-keys C-l \; run-shell "sleep .3s" \; clear-history

      # pass through xterm keys
      setw -g xterm-keys on

      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      setw -g monitor-activity on
      setw -g visual-activity on

      # Ctrl - t or t new window
      unbind C-t
      bind-key C-t new-window

      # Use Alt-vim keys without prefix key to switch panes
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Shift arrow to switch windows
      bind -n C-h  previous-window
      bind -n C-l next-window

      #  modes
      set -g clock-mode-colour colour5
      set -g mode-style 'bg=colour5 fg=colour255 bold'

      # panes
      set -g pane-border-style 'fg=colour0'
      set -g pane-active-border-style 'fg=colour0'

      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'bg=colour0 fg=colour255'
      set -g status-left ""
      set -g status-right '#[bg=colour5] %d/%m #[bg=colour2] %H:%M #[default]'
      set -g status-right-length 50
      set -g status-left-length 20

      set -g window-status-current-style 'bg=colour4 fg=colour255 bold'
      set -g window-status-current-format ' #[fg=colour2]#I: #[fg=colour255]#W#F '

      set -g window-status-style 'bg=colour0 fg=colour255'
      set -g window-status-format ' #[fg=colour2]#I: #[fg=colour255]#W#F '

      set -g window-status-bell-style 'bg=colour0 fg=colour255 bold'

      # messages
      set -g message-style 'bg=colour4 fg=colour255 bold'

    '';
  };

  # home.file.".tmux.conf".source = ./files/.tmux.conf;
}
