{
  description = "melos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;
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
        ];
      };
      leafeon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/leafeon/configuration.nix
          ./modules/nextcloud.nix
          #./modules/navidrome.nix
          ./modules/sops.nix
          ./modules/nginx.nix
          ./modules/server_base.nix
          sops.nixosModules.sops
        ];
      };
    };
  };
}
