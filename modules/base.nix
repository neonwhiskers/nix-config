{ config, pkgs, lib, options, ... }:
{
  imports = [
    ./server_base.nix
  ];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "steam-original"
    "steam"
    "discord"
  ];

  environment.sessionVariables = { GTK_THEME = "Adwaita:dark"; };

  services = {
    accounts-daemon.enable = true;
    printing.enable = true;
    illum.enable = true;
    yubikey-agent = {
      enable = true;
    };
    udev.packages = [ pkgs.yubikey-personalization ];
    tlp = {
      enable = true;
      settings = {
        "USB_BLACKLIST" = "1d50:604b 1d50:6089 1d50:cc15 1fc9:000c";
      };
    };

  };
  fonts.fontconfig = {
    enable = true;
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    font-awesome
    font-awesome_5
    nerdfonts
  ];

  environment.systemPackages = with pkgs; [
    acpi # battery stuff
    home-manager # managing homespace and user software
    alsa-utils # audio controll
    pinentry # password entry window required for gpg
    dconf # required by paprefs
    nix-index # indexing nix packages
    openssl
    libtool
    glibc
    firefox
    signal-desktop
    spotify-qt
    filezilla
    thunderbird
    libreoffice
    steam
    discord
    lutris

    wine
    wine-wayland
    winePackages.full

    slurp # screenshotting
    grim # screenshotting

    termusic # nice music player

    # different common fonts for icons 
    dejavu_fonts
    font-awesome
    font-awesome_5
    unicode-emoji

    # audio foo
    pulsemixer
    blueberry

    # development
    vscode
    gcc
    okular
  ];


  environment.shellInit = ''export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
  '';

  programs = {
    mosh.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ssh = {
      startAgent = false;
    };
  };
}

