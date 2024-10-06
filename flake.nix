{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_22_11.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // inputs.home-manager.lib;
  in {
    nixosConfigurations = {
      "starf0rge" = lib.nixosSystem {
        specialArgs = {inherit inputs;};

        modules = [
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
          ./modules/nixos
          ./modules/pcloud
        ];
      };
    };

    formatter = flake-utils.lib.eachDefaultSystemPassThrough (system: {
      ${system} = nixpkgs.legacyPackages.${system}.alejandra;
    });

    homeConfigurations = flake-utils.lib.eachDefaultSystemPassThrough (system: {
      "${system}.darth10" = lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          ./modules/home-manager
          inputs.nix-index-database.hmModules.nix-index
        ];
      };
    });
  };
}
