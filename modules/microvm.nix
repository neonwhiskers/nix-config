{pkgs, config, lib, ...}: let
  microvm = {
    watch-me-senpai.flakeref = "github:dump-dvb/nix-config";
  };
in {
  microvm.autoStart = builtins.attrNames microvms;
}
