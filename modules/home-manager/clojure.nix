{self, ...}: {
  flake.modules.homeManager.clojure = {
    pkgs,
    config,
    ...
  }: {
    home = let
      homeModulesDir = (self.settings.getDirs pkgs).homeModules;
    in {
      file."${config.xdg.configHome}/nrepl/nrepl.edn".source = config.lib.file.mkOutOfStoreSymlink "${homeModulesDir}/clojure/nrepl.edn";
      file."${config.xdg.configHome}/clojure/deps.edn".text = ''
        {
          :mvn/local-repo "${config.xdg.dataHome}/mvn/"

          :aliases {
            ;; Add cross-project aliases here
          }
        }
      '';
    };
  };
}
