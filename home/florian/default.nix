# Configuration utilisateur de florian, gérée par home-manager.
# Modifier puis :
#   cd ~/nixos-config && git add -A && git commit -m "..."
#   sudo nixos-rebuild switch --flake .#nixos-dev
{ pkgs, ... }:
{
  imports = [
    ./waybar.nix
    ./wofi.nix
    ./mako.nix
    ./kitty.nix
    ./hyprlock.nix
    ./wlogout.nix
    ./gtk.nix
  ];

  home.username = "florian";
  home.homeDirectory = "/home/florian";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # Outils utilisateur
    claude-code
    gh
    obsidian
    jetbrains.idea-ultimate
    jq
    bc
    libsecret
    vivaldi
    # Polices
    nerd-fonts.jetbrains-mono
    font-awesome
    # Audio / réseau (control panels)
    pavucontrol
    networkmanagerapplet
    # Polkit agent (popup mot de passe pour apps GUI)
    polkit_gnome
    # Wallpaper daemon
    swww
    # Screenshots
    grim
    slurp
    hyprshot
    # Clipboard manager
    wl-clipboard
    cliphist
  ];

  fonts.fontconfig.enable = true;

  services.cliphist.enable = true;

  home.file."Pictures/wallpaper.png".source = ./files/wallpaper.png;

  # Agent polkit (popup mot de passe pour apps GUI)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Git — identité et préférences
  programs.git = {
    enable = true;
    userName = "Florian Flahaut";
    userEmail = "fflahaut@flal.fr";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Bash — alias pratiques
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lh";
      la = "ls -la";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos-dev";
      nflake = "cd ~/nixos-config";
      cc = "cd ~/obsidian-vault && claude";
    };
  };

  # direnv : déclenche automatiquement des shells Nix par projet (.envrc)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # === Fichiers de config "bruts" gérés par home-manager ===
  # Ils sont stockés comme fichiers normaux dans home/florian/files/ et
  # symlinkés dans ~/.config/. Édite-les dans le repo puis rebuild.
  xdg.configFile."hypr/hyprland.conf".source = ./files/hyprland.conf;
  xdg.configFile."sunshine/sunshine.conf".source = ./files/sunshine.conf;
}
