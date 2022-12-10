{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect

  ];

  sops.defaultSopsFile = ../../secrets/leafeon.yaml;
  system.stateVersion = "22.05";

  boot.cleanTmpDir = true;
  boot.loader.grub.device = "/dev/vda";
  zramSwap.enable = true;
  networking.hostName = "leafeon";
  networking.domain = "";
}
