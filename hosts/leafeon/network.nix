{ pkgs, config, lib, ... }: {
  networking = {
    useDHCP = true;
    interfaces."eth0".useDHCP = true;
    useNetworkd = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  systemd.network = {
    enable = true;

    networks."10-ether-bond" = {
      matchConfig = {
        Name = "ens3";
      };
      networkConfig = {
        IPv6AcceptRA = "yes";
        Address = "202.61.250.106/22";
        Gateway = "202.61.248.1";
      };
    };
  };

  services.resolved = {
    enable = true;
    fallbackDns = [
      "8.8.8.8"
      "2001:4860:4860::8844"
    ];
  };
}
