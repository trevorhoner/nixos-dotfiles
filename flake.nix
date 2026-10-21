{
  description = "Multi-host NixOS for multiple machines";
    
    inputs.nur.url = "github:nix-community/NUR";

    inputs = {
    	nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      mangowm = {
        url = "github:mangowm/mango";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      waybar = {
        url = "github:Alexays/Waybar";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      noctalia = {
        url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      noctalia-greeter = {
        url = "github:noctalia-dev/noctalia-greeter";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

	    home-manager = {
	      url = "github:nix-community/home-manager/release-26.05";
	      inputs.nixpkgs.follows = "nixpkgs";
	    };

      hjem = {
        url = "github:feel-co/hjem";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

    };
  
    outputs = inputs@{ self, nixpkgs, home-manager, ... }:
      let
        mkMachine = hostname: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs hostname; };
          modules = [
            ./machines/${hostname}
            home-manager.nixosModules.home-manager
            inputs.hjem.nixosModules.default
            { networking.hostName = hostname; }
          ];
        };
      in 
      {
	      nixosConfigurations ={
          battlestation = mkMachine "battlestation";
          thinkpad-p52        = mkMachine "thinkpad";
       };
      };
}
