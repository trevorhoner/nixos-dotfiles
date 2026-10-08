{
  description = "Build NixOS from scratch!";

    inputs = {
    	nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      mangowm = {
        url = "github:mangowm/mango";
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
    };
  
    outputs = inputs@{ nixpkgs, home-manager, ... }: {
	    nixosConfigurations.battlestation = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
	      system = "x86_64-linux";
	      modules = [
          ./configuration.nix
		      home-manager.nixosModules.home-manager
		  {
		    home-manager = {
			  useGlobalPkgs = true;
			  useUserPackages = true;
			  users.trevor = import ./home.nix;
			  backupFileExtension = "backup";
		    };
		  }
	      ];
      };
    };
}
