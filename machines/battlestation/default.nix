{ lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/battlestation/noctalia.nix
      ../../modules/battlestation/noctalia-greeter.nix
      ../../modules/battlestation/mango.nix
      ../../modules/battlestation/fzf.nix
      ../../modules/battlestation/hjem.nix
      ../../modules/battlestation/system-packages.nix
      #../../modules/misc/pvpn.nix
    ];

  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; 
  boot.loader.grub.useOSProber = true;

  #IWD configurations
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "America/New_York";

  #Services-----------------------------
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    fade = false;
    shadow = false;
  };

  #Networking-----------------------------------
  networking.hostName = "battlestation"; 
  networking.networkmanager.enable = true;
  networking.wg-quick.interfaces.wg0 = {
    autostart = false;
    configFile = "/etc/wireguard/NixOS-FL.conf";
  };
  
#Users------------------------------------
	home-manager = {
	  useGlobalPkgs = true;
	  useUserPackages = true;
	  users.trevor = import ./home.nix;
	  backupFileExtension = "backup";
	};

  users.users.trevor = {
    isNormalUser = true;
    extraGroups = [
    "wheel"
    "video"
    "audio"
    ]; 
  };

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  programs.firefox.enable = true;

  programs.bash = {
	  enable = true;
	  shellAliases = { 
	    btw = "echo I use nixos, btw";
      nrs = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles#battlestation"; 
      nrs-dry = "sudo nixos-rebuild test --flake ~/.nixos-dotfiles#battlestation"; 
	  };
  };

  fonts.packages = with pkgs; [
#     nerd-fonts.caskaydia-cove
     nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) 
  [ "steam" "steam-unwrapped" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; 

}
