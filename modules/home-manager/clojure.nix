{...}: {
  flake.modules.homeManager.clojure = {config, ...}: {
    home = {
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
