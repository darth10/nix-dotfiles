{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_22_11.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";

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
          ./modules/nixos/configuration.nix
          ./modules/nixos/pcloud.nix
        ];
      };
    };

    formatter = flake-utils.lib.eachDefaultSystemPassThrough (system: {
      ${system} = nixpkgs.legacyPackages.${system}.alejandra;
    });

    # TODO specify the flake in install.sh using:
    # sys=".#$(nix eval --impure --raw --expr builtins.currentSystem).darth10"
    homeConfigurations = flake-utils.lib.eachDefaultSystemPassThrough (system: {
      "${system}.darth10" = lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          ./modules/home-manager/home.nix
          inputs.nix-index-database.hmModules.nix-index
        ];
      };
    });
  };
}
