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

  outputs = { self, nixpkgs, nixpkgs_22_11, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      pkgs_22_11 = import nixpkgs_22_11 {
        inherit system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) (map nixpkgs.lib.getName [
            pkgs_22_11.pcloud
          ]);
      };
    in {
      nixosConfigurations."starf0rge" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; inherit pkgs_22_11; };
        modules = [
          ./modules/nixos/configuration.nix
          ({ pkgs, ... }: {
              environment.systemPackages = [
                self.packages.${pkgs.stdenv.system}.pcloud
              ];
          })
        ];
      };

      homeConfigurations."darth10" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./modules/home-manager/home.nix
          inputs.nix-index-database.hmModules.nix-index
        ];
      };

      packages.${system}.pcloud = pkgs_22_11.pcloud.overrideAttrs (prev:
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
