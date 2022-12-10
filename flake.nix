{
	description = "mellos based nix configs";
 	inputs = {
		nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
	};
	outputs = {self, nixpkgs, ...}: {
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
                                        ./modules/yubikey.nix
				];
			};
		};
	};

}
