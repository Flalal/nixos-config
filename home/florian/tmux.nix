{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-b";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    terminal = "tmux-256color";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style digital
          set -g @tokyo-night-tmux_pane_id_style hsquare
          set -g @tokyo-night-tmux_zoom_id_style dsquare
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative
          set -g @tokyo-night-tmux_show_git 1
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
      # Splits gardent le pwd courant
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config rechargée"

      # Sessionizer (prefix + f) : fzf parmi les projets dans ~/dev et ~/obsidian-vault
      bind-key f run-shell "tmux neww ~/.config/tmux/sessionizer.sh"

      # Navigation panes plus naturelle (sans préfixe, intégré vim-tmux-navigator)
      # Ctrl+h/j/k/l déjà géré par vim-tmux-navigator

      # Renumber windows à la fermeture
      set -g renumber-windows on

      # Focus events (pour autoread vim)
      set -g focus-events on

      # 24-bit colors
      set -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };

  xdg.configFile."tmux/sessionizer.sh" = {
    source = ./files/sessionizer.sh;
    executable = true;
  };
}
