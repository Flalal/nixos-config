{ pkgs, ... }:
{
  # Côté système (configuration.nix du host laptop), penser à activer :
  #   hardware.bluetooth.enable = true;
  #   hardware.bluetooth.powerOnBoot = true;
  #   services.blueman.enable = true;
  #
  # Le module ici ne fait que l'applet GUI côté user.

  home.packages = with pkgs; [
    blueman
  ];

  # blueman-applet sera lancé via Hyprland exec-once (à ajouter conditionnellement
  # dans hyprland.conf au moment de la migration laptop) :
  #   exec-once = blueman-applet
}
