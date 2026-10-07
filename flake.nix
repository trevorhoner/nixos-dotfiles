{
  description = "Build NixOS from scratch!";

    inputs = {
    	nixpkgs.url = "nixpkgs/nixos-unstable";
      mangowm = {
        url = "github:mangowm/mango";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      noctalia = {
        url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs";
      };

	    home-manager = {
	      url = "github:nix-community/home-manager/release-26.05";
	      inputs.nixpkgs.follows = "nixpkgs";
	    };
    };
  
    outputs = { nixpkgs, home-manager, ... }: {
	    nixosConfigurations.battlestation = nixpkgs.lib.nixosSystem {
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
