{self, ...}: {
  flake.modules.homeManager.ssh = {
    pkgs,
    config,
    ...
  }: let
    homeModulesDir = (self.settings.getDirs pkgs).homeModules;
  in {
    home = {
      file.".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${homeModulesDir}/ssh/config";
    };
  };
}
