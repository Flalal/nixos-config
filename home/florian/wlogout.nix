{ ... }:
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Verrouiller";
        keybind = "l";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Déconnexion";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Veille";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Redémarrer";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Éteindre";
        keybind = "s";
      }
    ];

    style = ''
      * {
        background-image: none;
        box-shadow: none;
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 16px;
      }

      window {
        background-color: rgba(36, 40, 59, 0.88);
      }

      button {
        color: #c0caf5;
        background-color: rgba(31, 35, 53, 0.85);
        border: 2px solid rgba(122, 162, 247, 0.25);
        border-radius: 14px;
        margin: 14px;
        transition: all 0.2s ease;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: rgba(122, 162, 247, 0.18);
        border: 2px solid #7aa2f7;
        color: #7aa2f7;
        outline-style: none;
      }
    '';
  };
}
