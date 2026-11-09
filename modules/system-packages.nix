{ pkgs, ... }:

{

  hardware.xpadneo.enable = true;

  programs = {
    thunar = {
      enable = true;
    };

    xfconf.enable = true;
    dconf.enable = true;

  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };

  programs.amnezia-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    lsd
    gnome-calculator
    amnezia-vpn
    vim 
    wget
    tree
    linuxPackages.xpadneo
    godu
    thunar-archive-plugin
    thunar-volman
    ncdu
    xdg-utils
    git
    alacritty
    picom
    htop
    lutris
    wireguard-tools
    wireguard-ui
    xclip
    maim
    bluez
    fuseiso
    gtk-engine-murrine
    xscreensaver
    brave
    usbutils
    udisks
    unrar
    v4l-utils
    ffmpeg
    feh
    gobject-introspection
    (python314.withPackages (ps: with ps; [
      openpyxl
    ]))
    imagemagick
  ];

}
