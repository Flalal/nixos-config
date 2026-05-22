# Configuration utilisateur de florian, gérée par home-manager.
# Modifier puis :
#   cd ~/nixos-config && git add -A && git commit -m "..."
#   sudo nixos-rebuild switch --flake .#nixos-dev
{ pkgs, ... }:
{
  imports = [ ./waybar.nix ./wofi.nix ];

  home.username = "florian";
  home.homeDirectory = "/home/florian";
  home.stateVersion = "25.11";

  # Paquets installés rien que pour florian (en plus de ceux du système)
  home.packages = with pkgs; [
    claude-code
    gh
    obsidian
    jetbrains.idea-ultimate
    jq
    bc
    libsecret
    vivaldi
    # Dépendances Waybar
    nerd-fonts.jetbrains-mono
    font-awesome
    pavucontrol
    networkmanagerapplet
    wlogout
  ];

  fonts.fontconfig.enable = true;

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
