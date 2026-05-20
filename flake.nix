{
  description = "Configuration NixOS de Florian";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = {
      # nixos-dev : VM de développement remote sur Proxmox pve2
      nixos-dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/nixos-dev/configuration.nix ];
      };
    };
  };
}
