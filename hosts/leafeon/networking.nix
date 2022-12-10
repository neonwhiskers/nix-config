{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "8.8.8.8"
    ];
    defaultGateway = "202.61.248.1";
    defaultGateway6 = "fe80::1";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address = "202.61.250.106"; prefixLength = 22; }
        ];
        ipv6.addresses = [
          { address = "2a03:4000:54:cc6:b8db:b0ff:feb2:45ef"; prefixLength = 64; }
          { address = "fe80::b8db:b0ff:feb2:45ef"; prefixLength = 64; }
        ];
        ipv4.routes = [{ address = "202.61.248.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "fe80::1"; prefixLength = 128; }];
      };

    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="ba:db:b0:b2:45:ef", NAME="eth0"
    ATTR{address}=="02:42:8f:b5:f3:48", NAME="br-211236bd4ffb"
  '';
}
