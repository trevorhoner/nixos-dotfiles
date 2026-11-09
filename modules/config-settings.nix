{ config, pkgs, ... }:


let

  home                = config.home.homeDirectory;
  dotfiles            = "${home}/.nixos-dotfiles/config";
  lutrisRepo          = "${home}/.nixos-dotfiles/lutris";

  link       = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
  lutris     = path: config.lib.file.mkOutOfStoreSymlink "${lutrisRepo}/${path}";
in
{

    xdg.configFile = { 
      "alacritty" = { source = link "alacritty"; };
      "lsd"       = { source = link "lsd"; };
      "nvim"      = { source = link "nvim"; };
      "rofi"      = { source = link "rofi"; };
      "oxwm"      = { source = link "oxwm"; };
      "mango"     = { source = link "mango";};
      "waybar"    = { source = link "waybar";};
      "fastfetch" = { source = link "fastfetch";};
    };

    xdg.stateFile = {
      "noctalia/settings.toml".source   = link "noctalia/settings.toml";
    };

    xdg.dataFile = {
      "lutris/games".source         = lutris "games";
      "lutris/system.yml".source    = lutris  "system.yml";
      "lutris/lutris.conf".source   = lutris  "lutris.conf";
      "lutris/pga.db".source        = lutris  "pga.db";
      "lutris/banners".source       = lutris  "banners";
      "lutris/coverart".source      = lutris  "coverart";
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

    programs.pywal.enable = true;
}
