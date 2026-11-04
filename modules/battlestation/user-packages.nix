{ pkgs, ... }:
{
  gtk = {
    enable = true;

    #GTK Application theme
    theme = {
      name = "Nightfox-Dark";
      package = pkgs.nightfox-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.packages = with pkgs; [
  	neovim
  	ripgrep
  	nil
  	nixpkgs-fmt
  	nodejs
  	gcc
    rofi
    pywal
    gimp
    fastfetch
    freecad
    pcsx2
    btop
    grim
    slurp
    transmission_4-qt
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    papirus-icon-theme
    iwd
    thunar
    gvfs
    gtk4
    proton-vpn
    proton-vpn-cli
    wineWow64Packages.stableFull
    winetricks
    mono
    onlyoffice-desktopeditors
    grub2
    os-prober
    unzip
    _7zz
    restic
    udisks
    steam 
    wpgtk
    gamescope
    discord
    nanosaur
    nanosaur2
  ];
}
