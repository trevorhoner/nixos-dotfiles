{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "battlestation"; 
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  services.displayManager.ly.enable = true;
  services.xserver = {
	enable = true;
	autoRepeatDelay = 200;
	autoRepeatInterval = 35;
	windowManager.qtile.enable = true;
  };

  users.users.trevor = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    alacritty
    lutris
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) 
  [ "steam" "steam-unwrapped" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11"; 

}

