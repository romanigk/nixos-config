{
  description = "Personal Nix and NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        pulse-gen1 = lib.nixosSystem {
	  inherit system;
	  modules = [
	    ./configuration.nix
	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.p1ng0ut = {
	        imports = [ 
		  ./home.nix
		  ./git.nix
		  ./fish.nix
		];
	      };
	    }
	  ];
	};
      };
      homeManagerConfiguration = {
        pulse-gen1 = home-manager.lib.homeManagerConfiguration {
	  inherit system pkgs;
	  modules = [
	    ./home.nix
	  ];
	};
      };
    };
}
