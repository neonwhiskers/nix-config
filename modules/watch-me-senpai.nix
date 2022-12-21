{ pkgs, config, lib, ... }: {
  system.stateVersion = "22.11";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 ];
  };

  environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

}
