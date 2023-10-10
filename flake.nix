{
  description = "melos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;
    sops.url = github:mic92/sops-nix;

    documentation-src = {
      url = "github:neonwhiskers/projekte-afbb";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, sops, documentation-src, ... }: {
    nixosConfigurations = {

      umbreon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/umbreon/configuration.nix
          ./modules/base.nix
          ./modules/wayland.nix
          ./modules/pipewire.nix
          ./modules/bluetooth.nix
          ./modules/zsh.nix
        ];
      };

      leafeon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/leafeon/configuration.nix
          ./modules/leafeon/nextcloud.nix
          ./modules/leafeon/sops.nix
          ./modules/leafeon/nginx.nix
          ./modules/leafeon/base.nix
          ./modules/leafeon/backup.nix
          ./modules/leafeon/documentation.nix


          sops.nixosModules.sops


          {
            nixpkgs.overlays = [
              (final: prev: {
                inherit documentation-src;
              })
            ];
          }

        ];
      };
    };
  };
}
