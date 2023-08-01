{ config, pkgs, ... }: {

# system.stateVersion = "22.05";

# networking.hostName = "netbox";
# networking.domain = "domain.tld";

  services.netbox.enable = true;
  services.netbox.secretKeyFile = "/var/lib/netbox/passwordFile";

  services.nginx.enable = true;
# services.nginx.recommendedOptimisation = true;
#  services.nginx.recommendedGzipSettings = true;

# services.nginx.recommendedProxySettings = true;
  services.nginx.virtualHosts."${config.networking.fqdn}" = {
    locations = {
      "/" = {
#        extraConfig = ''
##          proxy_pass http://127.0.0.1:8001;
#          proxy_pass http://[::1]:8001;
#          proxy_set_header X-Forwarded-Host $http_host;
#          proxy_set_header X-Real-IP $remote_addr;
#          proxy_set_header X-Forwarded-Proto $scheme;
#        '';
#        proxyPass = "http://127.0.0.1:8001";
        proxyPass = "http://[::1]:8001";
####        proxyPass = "http://${config.services.netbox.listenAddress}:${config.services.netbox.port}";
      };
      "/static/" = {
#        extraConfig = ''
#          alias /var/lib/netbox/static/;
#        '';
#        alias = "/var/lib/netbox/static/";
        alias = "${config.services.netbox.dataDir}/static/";
      };
    };
    forceSSL = true;
    enableACME = true;
#    serverName = "${config.networking.hostName}.${config.networking.domain}";
    serverName = "${config.networking.fqdn}";
  };
  services.nginx.clientMaxBodySize = "25m";
  services.nginx.user = "netbox";
# services.nginx.recommendedTlsSettings = true;
  security.acme.defaults.email = "acme@${config.networking.domain}";
  security.acme.acceptTerms = true;

#  networking.firewall.allowedTCPPorts = [ 80 443 8001 ];
   networking.firewall.allowedTCPPorts = [ 80 443 ];
}
