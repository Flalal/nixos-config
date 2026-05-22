# Modules laptop (dormants)

Ce dossier contient des modules home-manager spécifiques laptop, **non importés**
sur le host `nixos-dev` (VM QEMU sans batterie / brightness / bluetooth).

## Pour activer sur un futur laptop

Dans `home/florian/default.nix`, ajouter `./laptop` à la liste `imports` :

```nix
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
  ./laptop          # <-- ajouter cette ligne
];
```

Puis `nrs`.

## Contenu

- `hypridle.nix` : auto-lock après 5 min, écran off après 10 min (hyprlock-couplé)
- `brightness.nix` : binds XF86MonBrightness via brightnessctl (déjà câblés en VM mais
  brightnessctl renvoie une erreur sans backlight sysfs réel)
- `bluetooth.nix` : blueman-applet + exec-once dans la session graphique

## Notes sur la migration

Le module `waybar.nix` n'inclut **pas** de battery par défaut. Pour l'ajouter sur le
laptop, ouvrir `home/florian/waybar.nix` et :

1. Ajouter `"battery"` dans `modules-right` (à côté de `network`)
2. Ajouter le bloc `battery = { format = " {capacity}%"; ... }` dans `settings.mainBar`

Idem pour `backlight` si tu veux l'afficher dans la barre.
