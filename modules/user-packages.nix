{ pkgs, ... }:
{

  gtk = {
    enable = true;

    #GTK Application theme
    theme = {
      #name = "Nightfox-Dark";
      #package = pkgs.nightfox-gtk-theme;
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Faba-Dark";
      package = pkgs.faba-icon-theme;
    };

    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 24;
    };

  };

  home.packages = with pkgs; [
    foliate
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
