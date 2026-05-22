# Bluetooth — dongle USB TP-Link UB500 passé à la VM Proxmox.
# Le module home-manager laptop/bluetooth.nix (blueman-applet) reste dormant ;
# blueman est ici activé côté système pour avoir l'applet dispo dans toute session.
{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;
}
