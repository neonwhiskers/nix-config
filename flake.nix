{
  description = "melos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    sops.url = github:mic92/sops-nix;
    funkwhale.url = github:revol-xut/funkwhale-flake;
  };
  outputs = { self, nixpkgs, sops, funkwhale, ... }: {
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
          ./modules/nvim.nix
          ./modules/docker.nix
        ];
      };
      leafeon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/leafeon/configuration.nix
          ./modules/nextcloud.nix
          ./modules/funkwhale.nix
          ./modules/sops.nix
          ./modules/nginx.nix
          ./modules/server_base.nix
          ./modules/bookstack.nix
          sops.nixosModules.sops
          funkwhale.nixosModules.default
          {
            nixpkgs.overlays = [ funkwhale.overlays.default ];
          }
        ];
      };
    };
  };
}
