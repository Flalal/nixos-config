{ ... }:
{
  programs.wofi = {
    enable = true;

    settings = {
      width = 600;
      height = 380;
      location = "center";
      show = "drun";
      prompt = "  Rechercher";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 28;
      gtk_dark = true;
      hide_scroll = true;
      key_expand = "Tab";
    };

    style = ''
      /* Palette: Tokyo Night */
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 14px;
      }

      window {
        background-color: rgba(36, 40, 59, 0.96);
        border: 1px solid rgba(122, 162, 247, 0.4);
        border-radius: 12px;
        color: #c0caf5;
      }

      #input {
        background-color: #1f2335;
        color: #c0caf5;
        border: 1px solid #414868;
        border-radius: 8px;
        padding: 8px 12px;
        margin: 10px;
      }

      #input:focus {
        border: 1px solid #7aa2f7;
        outline: none;
      }

      #inner-box {
        background-color: transparent;
        margin: 4px 8px 8px 8px;
      }

      #outer-box {
        background-color: transparent;
        padding: 4px;
      }

      #scroll {
        background-color: transparent;
      }

      #text {
        color: #c0caf5;
        padding: 2px;
      }

      #entry {
        padding: 6px 10px;
        margin: 2px 4px;
        border-radius: 6px;
        background-color: transparent;
      }

      #entry image {
        margin-right: 8px;
      }

      #entry:selected {
        background-color: rgba(122, 162, 247, 0.18);
      }

      #entry:selected #text {
        color: #7aa2f7;
      }

      #entry:focus {
        background-color: rgba(122, 162, 247, 0.18);
      }
    '';
  };
}
