{ ... }:
{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 36;
      spacing = 0;
      margin-top = 8;
      margin-left = 8;
      margin-right = 8;

      modules-left = [ "clock" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "tray"
        "custom/exit"
      ];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
          urgent = "";
        };
        on-click = "activate";
        persistent-workspaces."*" = 5;
      };

      clock = {
        format = "  {:%H:%M}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "  muted";
        format-icons.default = [ "" "" "" ];
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "  {essid}";
        format-ethernet = "  {ifname}";
        format-disconnected = "  disconnected";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click = "nm-connection-editor";
      };

      cpu = {
        format = "  {usage}%";
        interval = 2;
      };

      memory = {
        format = "  {percentage}%";
        interval = 2;
      };

      tray = {
        icon-size = 18;
        spacing = 8;
      };

      "custom/exit" = {
        format = "";
        on-click = "wlogout";
        tooltip = false;
      };
    };

    style = ''
      /* Palette: Tokyo Night */
      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(26, 27, 38, 0.55);
        color: #c0caf5;
        border-radius: 12px;
        border: 1px solid rgba(122, 162, 247, 0.15);
      }

      #workspaces { padding: 0 4px; }

      #workspaces button {
        color: #565f89;
        padding: 0 6px;
        background: transparent;
        border: none;
        transition: color 0.2s ease;
      }

      #workspaces button.active { color: #7aa2f7; }
      #workspaces button.urgent { color: #f7768e; }
      #workspaces button:hover {
        color: #c0caf5;
        background: transparent;
        box-shadow: none;
        text-shadow: none;
      }

      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #tray,
      #custom-exit {
        padding: 0 10px;
      }

      #clock {
        font-weight: bold;
        color: #7aa2f7;
        padding-left: 14px;
      }

      #custom-exit {
        color: #f7768e;
        padding-left: 14px;
        padding-right: 14px;
      }

      #network.disconnected,
      #pulseaudio.muted {
        color: #f7768e;
      }

      tooltip {
        background: rgba(26, 27, 38, 0.95);
        border-radius: 8px;
        border: 1px solid rgba(122, 162, 247, 0.2);
      }

      tooltip label { color: #c0caf5; }
    '';
  };
}
