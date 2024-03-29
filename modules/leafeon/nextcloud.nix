{ config, pkgs, lib, ... }:
let
  domain = "cloud.eroshevich.me";
in
{
  sops.secrets.nextcloud_db_pass.owner = "nextcloud";
  sops.secrets.nextcloud_admin_pass.owner = "nextcloud";

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions = {
          "DATABASE nextcloud" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [ "nextcloud" ];
  };

  services.nextcloud = {
    enable = true;
    hostName = domain;
    https = true;
    package = pkgs.nextcloud26;
    enableBrokenCiphersForSSE = false;
    config = {
      dbtype = "pgsql";
      dbname = "nextcloud";
      dbhost = "/run/postgresql";
      dbpassFile = "${config.sops.secrets.nextcloud_db_pass.path}";
      overwriteProtocol = "https";
      adminuser = "admin";
      adminpassFile = "${config.sops.secrets.nextcloud_admin_pass.path}";
    };
  };

  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    enableACME = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  systemd.services.postgresql = {
    unitConfig = {
      TimeoutStartSec = 3000;
    };
    serviceConfig = {
      TimeoutSec = lib.mkForce 3000;
    };
    postStart = lib.mkAfter ''
      $PSQL -c "ALTER USER nextcloud WITH PASSWORD '$(cat ${config.sops.secrets.nextcloud_db_pass.path})';"
    '';
  };

}
