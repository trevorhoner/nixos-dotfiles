{ config, pkgs, ... }:
# Line 33 = package list
let
  home         = config.home.homeDirectory;
  common-dotfiles     = "${home}/.nixos-dotfiles/config";
  dotfiles     = "${home}/.nixos-dotfiles/config"; #!! Run sudo chown "user" ~/nixos-dotfiles/config
  lutrisRepo   = "${home}/.nixos-dotfiles/lutris";

  link       = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
  common       = path: config.lib.file.mkOutOfStoreSymlink "${common-dotfiles}/${path}";
  lutris     = path: config.lib.file.mkOutOfStoreSymlink "${lutrisRepo}/${path}";
in
{
    xdg.configFile = { 
      "alacritty" = { source = common "alacritty"; };
      "nvim"      = { source = common "nvim"; };
      "qtile"     = { source = common "qtile"; };
      "rofi"      = { source = common "rofi"; };
      "oxwm"      = { source = common "oxwm"; };
      "mango"     = { source = common "mango";};
      "wpg"       = { source = common "wpg"; };
    };

    xdg.dataFile = {
      "lutris/games".source         = lutris "games";
      "lutris/system.yml".source    = lutris  "system.yml";
      "lutris/lutris.conf".source   = lutris  "lutris.conf";
      "lutris/pga.db".source        = lutris  "pga.db";
      "lutris/banners".source       = lutris  "banners";
      "lutris/coverart".source      = lutris  "coverart";
    };

    xdg.stateFile = {
      "noctalia/settings.toml".source     = common "noctalia/settings.toml";
    };

    programs.git= {
      enable = true;
      settings = {
        user.name = "Trevor";
        user.email = "thoner1@protonmail.com";
        init.defaultBranch = "main";
        url."git@github.com:".insteadOf = "https://github.com";
      };
    };

    programs.ssh= {
      enable = true;
      enableDefaultConfig = false;
      settings."*".AddKeysToAgent = "yes";
      extraConfig = ''
        Host github.com
          HostName ssh.github.com
          Port 443
          User git
          IdentityFile ~/.ssh/thinkpad-p52
          IdentitiesOnly yes
        '';
    };

    home.stateVersion = "26.05";

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "Fusion";
      qt6ctSettings = {
        Appearance = {
          style = "Fusion";
          custom_palette = true;
          color_scheme_path = "${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/darker.conf";
          icon_theme = "Papirus-Dark";
          standard_dialogs = "xdgdesktopportal";
        };
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
      fastfetch
      freecad
      grim
      slurp
      transmission_4-qt
      qt6Packages.qt6ct
      libsForQt5.qt5ct
      papirus-icon-theme
      iwd
      thunar
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
