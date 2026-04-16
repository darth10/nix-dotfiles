{
  self,
  inputs,
  ...
}: let
  username = self.settings.username;
in {
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    legacyPackages.homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      modules = [
        self.modules.homeManager.${username}
        self.modules.homeManager.${self.settings.editor}
        self.modules.homeManager.clojure
        # self.modules.homeManager.gnome
        self.modules.homeManager.kitty
        self.modules.homeManager.npm
        self.modules.homeManager.pass
        # self.modules.homeManager.pcloud
      ];
    };
  };

  flake.modules.homeManager.${username} = {
    imports = with self.modules.homeManager;
      [
        base
        fonts
        git
        gnupg
        htop
        mise
        nh
        nixSettings
        packages
        shell
        ssh
        stateVersion
      ]
      ++ [inputs.nix-index-database.homeModules.nix-index];
  };
}
