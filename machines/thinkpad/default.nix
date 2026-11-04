{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/battlestation/noctalia.nix
      ../../modules/battlestation/mango.nix
      ../../modules/battlestation/noctalia-greeter.nix
      ../../modules/battlestation/fzf.nix
      ../../modules/battlestation/system-packages.nix
      ../../modules/battlestation/system-settings.nix
    ];

  #Networking-----------------------------------
  networking.hostName = "thinkpad"; 
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
