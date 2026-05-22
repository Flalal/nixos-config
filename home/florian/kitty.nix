{ ... }:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      background_opacity = "0.92";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      cursor_shape = "beam";
      cursor_blink_interval = "0.5";
      window_padding_width = 8;
      hide_window_decorations = "yes";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      scrollback_lines = 10000;
    };

    extraConfig = ''
      # Tokyo Night Storm
      foreground            #c0caf5
      background            #24283b
      selection_foreground  #c0caf5
      selection_background  #283457

      cursor                #c0caf5
      cursor_text_color     #24283b

      url_color             #73daca

      active_border_color   #7aa2f7
      inactive_border_color #29355a
      bell_border_color     #f7768e

      active_tab_foreground   #1d202f
      active_tab_background   #7aa2f7
      inactive_tab_foreground #545c7e
      inactive_tab_background #1f2335

      # black
      color0  #1d202f
      color8  #414868
      # red
      color1  #f7768e
      color9  #f7768e
      # green
      color2  #9ece6a
      color10 #9ece6a
      # yellow
      color3  #e0af68
      color11 #e0af68
      # blue
      color4  #7aa2f7
      color12 #7aa2f7
      # magenta
      color5  #bb9af7
      color13 #bb9af7
      # cyan
      color6  #7dcfff
      color14 #7dcfff
      # white
      color7  #a9b1d6
      color15 #c0caf5
    '';
  };
}
