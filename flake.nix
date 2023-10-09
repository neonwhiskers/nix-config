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
<<<<<<< HEAD
          #./modules/bookstack.nix
=======
>>>>>>> 5362b40f70302d8ca686865191c02ed99ee8f6bf
          sops.nixosModules.sops
        ];
      };
    };
  };
}
