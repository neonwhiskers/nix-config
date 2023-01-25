{
  description = "melos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    sops.url = github:mic92/sops-nix;
  };
  outputs = { self, nixpkgs, sops, ... }: {
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
          ./modules/navidrome.nix
          ./modules/sops.nix
          ./modules/nginx.nix
          ./modules/server_base.nix
          ./modules/bookstack.nix
          sops.nixosModules.sops
        ];
      };
    };
  };
}
