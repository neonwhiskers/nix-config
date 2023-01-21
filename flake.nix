{
  description = "mellos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    microvm.url = github:astro/microvm.nix;
    dump-dvb.url = github:dump-dvb/nix-config;
    sops.url = github:mic92/sops-nix;
    funkwhale.url = github:mmai/funkwhale-flake;
  };
  outputs = { self, nixpkgs, microvm, dump-dvb, sops, funkwhale, ... }: {
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
          microvm.nixosModules.host
          sops.nixosModules.sops
          funkwhale.nixosModule
        ];
      };
    };
  };
}
