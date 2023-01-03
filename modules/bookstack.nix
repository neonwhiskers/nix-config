{ config, lib, pkgs, ... }:
{
  services = {
    bookstack = {
      enable = true;
      hostname = "docu.digitalsocial.team";
      appURL = "https://docu.digitalsocial.team";
      #mail = {
      #  user = "melody@chaoskitten.de";
      #};

      nginx.enableACME = true;
      nginx.forceSSL = true;

      # Bookstack requires mariadb or mysql :<

      database = {
        user = "bookstack";
        host = "localhost";
        name = "bookstack";
	createLocally = true;
      };
      appKeyFile = "${config.sops.secrets.bookstack_appkey.path}";
      config = { };
    };
    mysql = {
      package = pkgs.mariadb;
      enable = true;
      /*ensureUsers = [
        {
          name = "bookstack";
          ensurePermissions = {
            "database.bookstack" = "ALL PRIVILEGES";
          };
        }
      ];
      ensureDatabases = [ "bookstack" ]; */
    };
  };
  sops.secrets.bookstack_appkey.owner = config.services.bookstack.user;
  sops.secrets.bookstack_db_pass.owner = config.services.bookstack.user;

  # SECURITY: ensure database is not exposed in /tmp
  systemd.services."restic-backups-bookstack-backup-remote".serviceConfig.PrivateTmp = true;
}
