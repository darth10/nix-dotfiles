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
  };

  outputs = { self, systems, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib // home-manager.lib;
      pkgsFor = lib.genAttrs (import systems) (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
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

      homeConfigurations = {
        "darth10@starf0rge" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./modules/home-manager/home.nix
            inputs.nix-index-database.hmModules.nix-index
          ];
        };
      };
    };
}
