{ pkgs, config, lib, ... }: {
  programs = {
    xwayland.enable = true;
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        swaylock-fancy 
        swayidle
        wl-clipboard
        mako
        alacritty
        wofi
        wofi-emoji
        gnome.adwaita-icon-theme
        i3status-rust
        swayr
        dmenu-wayland
        xdg-desktop-portal-wlr 
      ];
    };
  };

  services.xserver.xkbOptions = "compose:ralt";
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  

  environment.systemPackages = [ pkgs.xdg-desktop-portal-wlr ];
  xdg.portal.wlr.enable = true;
  services.xserver.displayManager.defaultSession = "sway";
  /*input type:keyboard {
    xkb_layout "us,de,ru"
    xkb_variant ,nodeadkeys
    xkb_options grp:win_space_toggle
    repeat_delay 250
    repeat_rate 30
    }*/
}
