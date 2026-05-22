{ ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "~/Pictures/wallpaper.png";
          blur_passes = 3;
          blur_size = 8;
          contrast = 0.9;
          brightness = 0.5;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "320, 60";
          outline_thickness = 2;
          dots_size = 0.22;
          dots_spacing = 0.4;
          dots_center = true;
          outer_color = "rgb(7aa2f7)";
          inner_color = "rgba(36, 40, 59, 0.85)";
          font_color = "rgb(c0caf5)";
          fade_on_empty = false;
          placeholder_text = "<i>Mot de passe...</i>";
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
          rounding = 10;
          check_color = "rgb(9ece6a)";
          fail_color = "rgb(f7768e)";
          fail_text = "<i>Mauvais mot de passe</i>";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%H:%M')\"";
          color = "rgba(c0caf5ff)";
          font_size = 110;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -260";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:60000] echo \"$(LC_TIME=fr_FR.UTF-8 date +'%A %d %B')\"";
          color = "rgba(a9b1d6ff)";
          font_size = 22;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -380";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = "  $USER";
          color = "rgba(7aa2f7ff)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
