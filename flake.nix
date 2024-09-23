{
  description = "dotfiles";

  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_22_11.url = "github:nixos/nixpkgs/nixos-22.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, systems, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib // inputs.home-manager.lib;
    in {
      nixosConfigurations = {
        "starf0rge" = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/nixos/configuration.nix
            ./modules/nixos/pcloud.nix
          ];
        };
      };
    } // inputs.flake-utils.lib.eachDefaultSystemPassThrough (system: {
      homeConfigurations = {
        "darth10" = lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./modules/home-manager/home.nix
            inputs.nix-index-database.hmModules.nix-index
          ];
        };
      };
    });
}
