# nixos-config

Configuration NixOS déclarative (flake) — Florian.

## Usage quotidien

Modifier la config puis appliquer :
```sh
sudo nixos-rebuild switch --flake ~/nixos-config#nixos-dev
```
N'oublie pas de `git commit` tes changements (Nix lit les fichiers suivis).

## Déployer sur une nouvelle machine

1. Installer NixOS minimal sur la nouvelle machine.
2. `git clone git@github.com:Flalal/nixos-config.git`
3. `nixos-generate-config --root /mnt` puis copier le nouveau
   `hardware-configuration.nix` dans `hosts/<nom-machine>/`.
4. Dupliquer/adapter `hosts/nixos-dev/configuration.nix` vers
   `hosts/<nom-machine>/configuration.nix`.
5. Déclarer le host dans `flake.nix`.
6. `nixos-rebuild switch --flake .#<nom-machine>`

## Structure

```
flake.nix                                  # déclare les hosts
hosts/<host>/configuration.nix             # config portable
hosts/<host>/hardware-configuration.nix    # matériel (spécifique machine)
```

## Pièges connus

- **Régénérer impérativement `hardware-configuration.nix` à chaque
  install (étape 3 ci-dessus).** Si le fichier committé garde les
  UUIDs/modules d'une autre machine, la nouvelle génération boote en
  *emergency mode* (`Dependency failed for /boot`, fsck timeout sur un
  UUID inexistant) et `switch-to-configuration` refuse d'installer le
  bootloader avec *« ESP mountpoint /boot is not a mounted partition »*.
  Récupération :
  1. Rebooter sur une génération antérieure depuis le menu systemd-boot.
  2. Corriger les UUIDs / modules avec `lsblk -no NAME,UUID,MOUNTPOINT`
     et `nixos-generate-config --show-hardware-config`, puis commit.
  3. Monter `/boot` à la main avant le `nrs` suivant :
     `sudo mount /dev/disk/by-uuid/<uuid-ESP> /boot`
     (sinon le bootloader install refuse de tourner).
