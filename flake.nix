{
  description = "dotfiles";

  inputs = {
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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib // home-manager.lib;
    in {
      nixosConfigurations = {
        "starf0rge" = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit inputs; };
          modules = [
            ./modules/nixos/configuration.nix
            ./modules/nixos/pcloud.nix
          ];
        };
      };

      homeConfigurations = {
        "darth10@starf0rge" = lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./modules/home-manager/home.nix
            inputs.nix-index-database.hmModules.nix-index
          ];
        };
      };
    };
}
