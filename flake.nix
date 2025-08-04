{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    systems.url = "github:nix-systems/default";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    deploy-rs,
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
          {
            desktop.gnome.enable = true;
            services.pcloud.enable = true;
            programs.doom-emacs.enable = true;
          }
        ];
      };
    });

    deploy.nodes.maelstrom = let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      deploy-pkgs = import nixpkgs {
        inherit system;
        overlays = [
          deploy-rs.overlays.default
          (self: super: {
            deploy-rs = {
              inherit (pkgs) deploy-rs;
              lib = super.deploy-rs.lib;
            };
          })
        ];
      };
    in {
      hostname = "maelstrom-node";
      profiles.home-manager = {
        user = "darth10";
        path = deploy-pkgs.deploy-rs.lib.activate.home-manager (
          lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {inherit inputs;};

            modules = [
              ./modules/home-manager
              ./modules/home-manager/maelstrom.nix
              inputs.nix-index-database.hmModules.nix-index
            ];
          }
        );
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
