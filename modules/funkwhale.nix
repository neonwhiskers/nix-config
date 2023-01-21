{pkgs, config, lib, ...}: {
  sops.secrets.funkwhale_db_pass.owner = "funkwhale";
  sops.secrets.funkwhale_django_secret.owner = "funkwhale";

  services.postgresql = {
    enable = true;
    /*ensureUsers = [
      {
        name = "funkwhale";
        ensurePermissions = {
          "DATABASE funkwhale" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [ "funkwhale" ];*/
  };

  services.funkwhale = {
      enable = true;
      hostname = "music.tassilo-tanneberger.de";
      protocol = "https";
      forceSSL = false; 
    
      database = {
        host = "localhost";
        port = 5432;
        name = "funkwhale";
        passwordFile = "${config.sops.secrets.funkwhale_db_pass.path}";
        createLocally = true;
      };

      defaultFromEmail = "service@music.tassilo-tanneberger.de";

      webWorkers = 2;

      api = {
        # Generate one using `openssl rand -base64 45`, for example
        djangoSecretKeyFile = "${config.sops.secrets.funkwhale_django_secret.path}";
      };
    };
 
    services.nginx.virtualHosts."music.tassilo-tanneberger.de" = {
      #forceSSL = true;
      enableACME = true;
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
}
