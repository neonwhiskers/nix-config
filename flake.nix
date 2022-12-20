{
  description = "mellos based nix configs";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    microvm.url = github:astro/microvm.nix;
    dump-dvb.url = github:dump-dvb/nix-config;
    sops.url = github:mic92/sops-nix;
  };
  outputs = { self, nixpkgs, microvm, dump-dvb, sops, ... }: {
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
          ./modules/sops.nix
          ./modules/nginx.nix
          ./modules/server_base.nix
          ./modules/bookstack.nix
          microvm.nixosModules.host
          sops.nixosModules.sops
          {
	    networking.nat = {
	      enable = true;
	      internalInterfaces = ["ve-+"];
	      externalInterface = "ens3";
	      # Lazy IPv6 connectivity for the container
	      enableIPv6 = true;
	    };
	    containers.watch-me-senpai = {
	    	autoStart = true;
		  privateNetwork = true;           
		  hostAddress = "192.168.100.10";
		  localAddress = "192.168.100.11";
		  config = { config, pkgs, ... 
	    };
            microvm.vms.watch-me-senpai = {
            	flake = dump-dvb;
                updateFlake = "github:dump-dvb/nix-config";
            };
          }
        ];
      };
    };
  };
}
