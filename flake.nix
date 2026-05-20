{
  description = "Configuration NixOS de Florian";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      # nixos-dev : VM de développement remote sur Proxmox pve2
      nixos-dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-dev/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # Si home-manager doit remplacer un fichier existant, il en garde
            # une copie en .hm-bak (utile lors de la 1re application).
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.florian = import ./home/florian;
          }
        ];
      };
    };
  };
}
