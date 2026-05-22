{ ... }:
{
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      default-timeout = 5000;
      margin = "12";
      padding = "12";
      width = 360;
      height = 110;
      border-radius = 10;
      border-size = 1;
      background-color = "#24283bf2";
      text-color = "#c0caf5";
      border-color = "#7aa2f7";
      progress-color = "over #3d59a1";
      font = "JetBrainsMono Nerd Font 11";
      icons = true;
      max-icon-size = 48;
      markup = 1;

      "urgency=low" = {
        background-color = "#1f2335f2";
        border-color = "#565f89";
      };

      "urgency=critical" = {
        background-color = "#24283bf2";
        border-color = "#f7768e";
        text-color = "#f7768e";
        default-timeout = 0;
      };
    };
  };
}
