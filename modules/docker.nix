{ pkgs, config, lib, ... }: {
  virtualisation.docker.enable = true;
  users.users.mel.extraGroups = [ "docker" ];
  virtualisation.docker.autoPrune.enable = true;
  environment.systemPackages = with pkgs; [ docker-compose ];
}
