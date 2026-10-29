{ config, pkgs, ... }:
# Line 33 = package list

let

  home                = config.home.homeDirectory;
  dotfiles            = "${home}/.nixos-dotfiles/config";
  lutrisRepo          = "${home}/.nixos-dotfiles/lutris";

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

    programs.git= {
      enable = true;
      settings = {
        user.name = "Trevor";
        user.email = "thoner1@protonmail.com";
        init.defaultBranch = "main";
        url."git@github.com:".insteadOf = "https://github.com";
      };

      lfs.enable = true;

    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*".AddKeysToAgent = "yes";
      extraConfig = ''
        Host github.com
          HostName ssh.github.com
          Port 443
          User git
          IdentityFile ~/.ssh/Battlestation
          IdentitiesOnly yes
        '';
    };

    home.stateVersion = "26.05";

    programs.bash = {
	    enable = true;
	    shellAliases = { 
	      btw = "echo I use nixos, btw";
        nrs = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles#battlestation"; 
        nrs-dry = "sudo nixos-rebuild test --flake ~/.nixos-dotfiles#battlestation"; 
	    };
      initExtra = ''
        fastfetch
      '';
    };

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
