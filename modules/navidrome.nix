{ config, ... }: {
  services.navidrome = {
    enable = true;
    settings = {
      Address = "127.0.0.1";
      BaseUrl = "/";
      EnableExternalServices = false;
      MusicFolder = "/var/lib/music";
      Port = 4533;
      ScanSchedule = "@every 11m";
      TranscondigCacheSize = "5GiB";
    };
  };

  services.nginx.virtualHosts."music.tassilo-tanneberger.de" = {
    enableACME = true;
    forceSSL = true;
    extraConfig = ''
    client_max_body_size 32M;
    '';
    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.navidrome.settings.Port}";
      };
    };
  };
}
