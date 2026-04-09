{ config, pkgs, ... }:
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
    };

    programs.git = {
      enable = true;
      userName = "Trevor";
      userEmail = "thoner1@protonmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    home.stateVersion = "25.11";
    programs.bash = {
	    enable = true;
	    shellAliases = { 
	      btw = "echo I use nixos, btw";
        nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#battlestation"; 
       #nrs-dry = "sudo nixos-rebuild test --flake ~/nixos-dotfiles#battlestation"; 
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
      neofetch
      fastfetch
    ];
}
