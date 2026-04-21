{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hosts/battlestation/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #Networking-----------------------------------
  networking.hostName = "battlestation"; 
  networking.networkmanager.enable = true;

  #IWD configurations
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "America/New_York";

  #Bluetooth--------------------------------------
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #Display-Manager------------------------------
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
    wireguard-tools
    wireguard-ui
    xclip
    maim
    bluez
    xscreensaver
    brave
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) 
  [ "steam" "steam-unwrapped" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11"; 

}

