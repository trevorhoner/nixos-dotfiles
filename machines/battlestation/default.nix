{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/noctalia.nix
      ../../modules/noctalia-greeter.nix
      ../../modules/mango.nix
      ../../modules/fzf.nix
      #../../modules/hjem.nix
      ../../modules/system-packages.nix
      ../../modules/system-settings.nix
    ];

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
}
