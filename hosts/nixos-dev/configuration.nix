# =============================================================================
#  configuration.nix — VM NixOS de développement (nixos-dev)
#  Généré par Claude. Tu peux tout modifier puis appliquer avec :
#      sudo nixos-rebuild switch
#  Pour annuler un changement : rebooter et choisir une génération précédente
#  dans le menu de démarrage, ou `sudo nixos-rebuild switch --rollback`.
# =============================================================================
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix   # matériel détecté automatiquement — ne pas éditer
  ];

  # --- Démarrage (UEFI) -------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;  # nb de générations dans le menu
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Réseau -----------------------------------------------------------------
  networking.hostName = "nixos-dev";
  networking.networkmanager.enable = true;   # DHCP automatique sur vmbr0
  # Le pare-feu est ACTIF par défaut. SSH et Sunshine ouvrent leurs ports plus bas.

  # --- Localisation -----------------------------------------------------------
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
  };
  console.keyMap = "fr";                      # clavier AZERTY en console TTY

  # --- Serveur d'affichage X11 (requis pour la session XFCE) ------------------
  services.xserver.enable = true;
  services.xserver.xkb.layout = "fr";         # clavier AZERTY sous X11

  # --- Gestionnaire de connexion : SDDM ---------------------------------------
  services.displayManager.sddm.enable = true;
  # Connexion automatique dans Hyprland : indispensable pour que Sunshine ait
  # toujours une session graphique à diffuser, même sans personne devant l'écran.
  # Pour passer sur XFCE : se déconnecter -> l'écran SDDM permet de choisir.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "florian";
  services.displayManager.defaultSession = "hyprland-uwsm";

  # --- Environnements de bureau ----------------------------------------------
  programs.hyprland.enable = true;                     # Hyprland (Wayland) — principal
  programs.hyprland.withUWSM = true;                   # session pilotée par systemd
                                                       # (active graphical-session.target
                                                       #  -> Sunshine démarre tout seul)
  services.xserver.desktopManager.xfce.enable = true;  # XFCE (X11) — secours

  # XDG portals — sélecteurs de fichier modernes + screensharing dans Vivaldi/Slack
  # (hyprland est déjà tiré par programs.hyprland, on ajoute gtk pour les dialogs)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # --- Son (PipeWire) ---------------------------------------------------------
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # Sink audio virtuel : la VM n'a pas de carte son. On crée une sortie
    # "null" pour que les applis aient une destination et que Sunshine puisse
    # la capturer (le moniteur du sink) -> son dans Moonlight.
    extraConfig.pipewire."10-sunshine-sink" = {
      "context.objects" = [{
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "sunshine-sink";
          "node.description" = "Sunshine Audio Sink";
          "media.class" = "Audio/Sink";
          "audio.position" = "[ FL FR ]";
          "priority.driver" = 2000;   # priorité haute => sink par défaut
          "priority.session" = 2000;
        };
      }];
    };
  };

  # --- Bureau distant : Sunshine (client : Moonlight) -------------------------
  services.sunshine = {
    enable = true;
    autoStart = true;     # démarre avec la session graphique
    capSysAdmin = true;   # requis pour la capture d'écran (KMS / Wayland)
    openFirewall = true;  # ouvre les ports Moonlight dans le pare-feu
  };

  # Accès à /dev/uinput : permet à Sunshine de créer la souris et le clavier
  # virtuels pilotés par Moonlight (sinon "Permission denied" -> pas de souris).
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  # --- Accès SSH --------------------------------------------------------------
  services.openssh.enable = true;             # ouvre le port 22 automatiquement

  # --- Intégration Proxmox ----------------------------------------------------
  services.qemuGuest.enable = true;           # agent invité QEMU

  # --- Accélération graphique -------------------------------------------------
  # Rendu logiciel (llvmpipe) : la VM n'a pas de GPU. Le passthrough de la
  # GTX 1050 a été abandonné (GPU de portable bloqué en D3cold). On autorise
  # explicitement le rendu logiciel pour que Hyprland démarre sans GPU.
  hardware.graphics.enable = true;
  environment.sessionVariables.WLR_RENDERER_ALLOW_SOFTWARE = "1";

  # --- Utilisateur ------------------------------------------------------------
  users.users.florian = {
    isNormalUser = true;
    description = "Florian";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    # /!\ MOT DE PASSE TEMPORAIRE — change-le dès la 1re connexion avec `passwd`
    # (c'est aussi le mot de passe sudo).
    initialPassword = "nixos";
  };

  # --- Nix : active les flakes (gestion de conf moderne, pour plus tard) ------
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Nettoyage automatique des vieilles générations (> 30 jours)
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # --- Paquets non-libres autorisés -------------------------------------------
  nixpkgs.config.allowUnfree = true;

  # --- Paquets système recommandés -------------------------------------------
  # Le minimum pour une session Hyprland utilisable + outils de base.
  # Ajoute/retire ce que tu veux puis `sudo nixos-rebuild switch`.
  environment.systemPackages = with pkgs; [
    git vim wget curl htop tree file unzip
    kitty        # émulateur de terminal (lancé par défaut par Hyprland : Super+Q)
    wofi         # lanceur d'applications (Hyprland : Super+R)
    waybar       # barre de statut
    firefox      # navigateur
    pavucontrol  # contrôle du volume audio
  ];

  # Version de NixOS d'origine — NE PAS modifier (gère la compatibilité).
  system.stateVersion = "25.11";
}
