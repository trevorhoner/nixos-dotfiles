{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vim 
    wget
    tree
    linuxPackages.xpadneo
    godu
    ncdu
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
