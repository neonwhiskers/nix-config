{ pkgs, config, lib, ... }: {
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "m3l0dy@tutamail.com";
  #security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
}
