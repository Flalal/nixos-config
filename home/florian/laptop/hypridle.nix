{ ... }:
{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;                           # 5 min
          on-timeout = "loginctl lock-session";    # auto-lock
        }
        {
          timeout = 600;                           # 10 min
          on-timeout = "hyprctl dispatch dpms off";  # éteint l'écran
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;                          # 30 min
          on-timeout = "systemctl suspend";        # mise en veille
        }
      ];
    };
  };
}
