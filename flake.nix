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

      pkgs_22_11 = import inputs.nixpkgs_22_11 {
        inherit system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) (map lib.getName [
            pkgs_22_11.pcloud
          ]);
      };
    in {
      nixosConfigurations = {
        "starf0rge" = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit inputs; };
          modules = [
            ./modules/nixos/configuration.nix
            ({ ... }: {
              environment.systemPackages = [
                self.packages.x86_64-linux.pcloud
              ];
            })
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

      packages.x86_64-linux.pcloud = pkgs_22_11.pcloud.overrideAttrs (prev:
        let
          version = "1.14.7";
          code = "XZhPkU0Zh5gulxHfMn4j1dYBS4dh45iDQHby";
          # Use codes from: https://www.pcloud.com/release-notes/linux.html
          src = pkgs.fetchzip {
            url = "https://api.pcloud.com/getpubzip?code=${code}&filename=${prev.pname}-${version}.zip";
            hash = "sha256-fzQVuCI3mK93Y3Fwzc0WM5rti0fTZhRm+Qj1CHC8CJ4=";
          };

          appimageContents = pkgs.appimageTools.extractType2 {
            name = "${prev.pname}-${version}";
            src = "${src}/pcloud";
          };
        in
          {
            inherit version;
            src = appimageContents;
          });
    };
}
