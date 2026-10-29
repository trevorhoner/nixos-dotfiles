{ config, pkgs, ... }:
# Line 33 = package list
let
  home         = config.home.homeDirectory;
  dotfiles     = "${home}/.nixos-dotfiles/config"; #!! Run sudo chown "user" ~/nixos-dotfiles/config
  lutrisRepo   = "${home}/.nixos-dotfiles/lutris";

  link       = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
  lutris     = path: config.lib.file.mkOutOfStoreSymlink "${lutrisRepo}/${path}";
in
{
    imports = [
      ../../modules/battlestation/user-packages.nix
    ];

    xdg.configFile = { 
      "alacritty" = { source = link "alacritty"; };
      "nvim"      = { source = link "nvim"; };
      "rofi"      = { source = link "rofi"; };
      "oxwm"      = { source = link "oxwm"; };
      "mango"     = { source = link "mango";};
    };

    xdg.stateFile = {
      "noctalia/settings.toml".source     = link "noctalia/settings.toml";
    };

    xdg.dataFile = {
      "lutris/games".source         = lutris "games";
      "lutris/system.yml".source    = lutris  "system.yml";
      "lutris/lutris.conf".source   = lutris  "lutris.conf";
      "lutris/pga.db".source        = lutris  "pga.db";
      "lutris/banners".source       = lutris  "banners";
      "lutris/coverart".source      = lutris  "coverart";
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

}
