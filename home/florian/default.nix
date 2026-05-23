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
    ./swayosd.nix
    ./tmux.nix
    # ./laptop      # dormant — voir laptop/README.md pour activer
  ];

  home.username = "florian";
  home.homeDirectory = "/home/florian";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # Outils utilisateur
    claude-code
    gh
    obsidian
    jetbrains.idea
    jq
    bc
    libsecret
    vivaldi
    fastfetch
    # Polices
    nerd-fonts.jetbrains-mono
    font-awesome
    # Audio / réseau (control panels)
    pavucontrol
    networkmanagerapplet
    nautilus
    gvfs
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
    # Dev — JS/TS toolchain (projet quizz-mariage : Next.js + SQLite + Drizzle)
    nodejs_22
    pnpm
    # Build natif pour modules npm avec addons C++ (ex: better-sqlite3)
    python3
    gcc
    gnumake
    # SQLite CLI (debug DB du quizz, drizzle-kit studio en alternative)
    sqlite
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
    settings = {
      user.name = "Florian Flahaut";
      user.email = "fflahaut@flal.fr";
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

  # fzf — fuzzy finder, intégration shell (Ctrl+R history, Ctrl+T files, Alt+C cd)
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--color=bg+:#283457,bg:#1f2335,spinner:#7dcfff,hl:#bb9af7"
      "--color=fg:#c0caf5,header:#bb9af7,info:#7aa2f7,pointer:#7dcfff"
      "--color=marker:#9ece6a,fg+:#c0caf5,prompt:#7aa2f7,hl+:#bb9af7"
      "--height 40% --layout=reverse --border"
    ];
  };

  # udiskie — auto-mount des USB + icône tray
  services.udiskie = {
    enable = true;
    tray = "auto";
    automount = true;
    notify = true;
  };

  # Vivaldi userCSS Tokyo Night (activation manuelle : Settings → Appearance →
  # Use Custom UI Modifications → pointer ~/.config/vivaldi-custom.css)
  xdg.configFile."vivaldi-custom.css".source = ./files/vivaldi-custom.css;

  # === Fichiers de config "bruts" gérés par home-manager ===
  # Ils sont stockés comme fichiers normaux dans home/florian/files/ et
  # symlinkés dans ~/.config/. Édite-les dans le repo puis rebuild.
  xdg.configFile."hypr/hyprland.conf".source = ./files/hyprland.conf;
  xdg.configFile."sunshine/sunshine.conf".source = ./files/sunshine.conf;
}
