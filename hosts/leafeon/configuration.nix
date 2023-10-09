{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./network.nix # generated at runtime by nixos-infect
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;

  sops.defaultSopsFile = ../../secrets/leafeon.yaml;
  system.stateVersion = "22.05";

  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/vda";
  zramSwap.enable = true;
  networking.hostName = "leafeon";
}
