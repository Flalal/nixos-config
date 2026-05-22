{ pkgs, ... }:
{
  # Binds brightness via swayosd-client (déjà installé) — affiche l'OSD en même temps.
  # Les binds XF86MonBrightnessUp/Down sont déjà dans hyprland.conf ; à migrer vers
  # swayosd-client --brightness raise/lower au prochain edit.
  #
  # Sur ce laptop : décommenter ce module, le rebuild ajoutera les outils ; les binds
  # restent dans hyprland.conf qui est partagé entre hosts.
  home.packages = with pkgs; [
    brightnessctl    # déjà présent en VM mais on l'ajoute ici pour explicite
    light            # alternative à brightnessctl si problème de permissions
  ];
}
