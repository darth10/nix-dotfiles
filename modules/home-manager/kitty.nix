{self, ...}: {
  flake.modules.homeManager.kitty = {
    pkgs,
    config,
    ...
  }: let
    homeModulesDir = (self.settings.getDirs pkgs).homeModules;
  in {
    home = {
      file."${config.xdg.configHome}/kitty".source = config.lib.file.mkOutOfStoreSymlink "${homeModulesDir}/kitty";

      shellAliases.icat = "kitty icat";
    };
  };
}
