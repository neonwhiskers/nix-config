{ config, pkgs, ... }: {
  systemd.network = {
    netdevs."microvm-bridge".netdevConfig = {
      Kind = "bridge";
      Name = "microvm-bridge";
    };

    networks."0-microvm-bridge" = {
      matchConfig.Name = "microvm-bridge";
      networkConfig = {
        DHCPServer = false;
        IPv6SendRA = true;
      };
      addresses = [{
        addressConfig.Address = "10.99.99.1/24";
      }
        {
          addressConfig.Address = "fd12:3456:789a::1/64";
        }];
      ipv6Prefixes = [{
        ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
      }];
    };

    networks."1-microvm-bridge" = {
      matchConfig.Name = "serv-dvb-*";
      networkConfig.Bridge = "microvm-bridge";
    };
  };

  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "wlan0";
    internalInterfaces = [ "microvm-bridge" ];
  };
}
