{self, ...}: {
  flake.modules.homeManager.pass = {
    pkgs,
    config,
    ...
  }: let
    homeDir = (self.settings.getDirs pkgs).home;
  in {
    home = {
      sessionVariables = {
        PASSWORD_STORE_DIR = "${homeDir}/Cloud/pass";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      };
    };
  };
}
