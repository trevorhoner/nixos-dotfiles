{ config, pkgs, ... }:
# Line 33 = package list
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
    xdg.configFile = { 
      "alacritty" = { source = link "alacritty"; };
      "nvim"      = { source = link "nvim"; };
      "qtile"     = { source = link "qtile"; };
      "rofi"      = { source = link "rofi"; };
      "oxwm"      = { source = link "oxwm"; };
    };

    programs.git = {
      enable = true;
      userName = "Trevor";
      userEmail = "thoner1@protonmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com:".insteadOf = "https://github.com";
      };
    };

    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = ''
        Host github.com
          HostName github.com
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
        nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#battlestation"; 
        nrs-dry = "sudo nixos-rebuild test --flake ~/nixos-dotfiles#battlestation"; 
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
      transmission_4-qt
      iwd
      thunar
      wineWow64Packages.stableFull
      winetricks
      mono
      onlyoffice-desktopeditors
      grub2
      os-prober
      unzip
      restic
      udisks
      steam 
      gamescope
      discord
      nanosaur
      nanosaur2
    ];
}
