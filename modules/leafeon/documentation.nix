{ pkgs, config, ... }:
let
  documentation-package = pkgs.callPackage ../../pkgs/documentation.nix { };
in
{
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "docs.eroshevich.me" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/" = {
              root = "${documentation-package}/bin/";
              index = "index.html";
            };
          };
        };
      };
    };
  };
}
