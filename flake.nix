{
  description = "mellos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    sops.url = github:mic92/sops-nix;
    dump-dvb-nix-config.url = github:dump-dvb/nix-config;
    dump-dvb.url = github:dump-dvb/dump-dvb.nix;
  };
  outputs = { self, nixpkgs, dump-dvb-nix-config, dump-dvb, sops, ... }: {
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
	specialArgs = { inherit dump-dvb; };
        modules = [
          ./hosts/leafeon/configuration.nix
          ./modules/nextcloud.nix
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
