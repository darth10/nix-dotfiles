{
  self,
  inputs,
  ...
}: {
  flake.deploy.nodes.maelstrom = let
    username = self.settings.username;
    system = "aarch64-linux";
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    deploy-pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        inputs.deploy-rs.overlays.default
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
      user = username;
      path = deploy-pkgs.deploy-rs.lib.activate.home-manager (
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            self.modules.homeManager.${username}
            self.modules.homeManager.maelstrom
            self.modules.homeManager.vim
          ];
        }
      );
    };
  };

  flake.checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
}
