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
        PASSWORD_STORE_DIR = "${homeDir}/.pass";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";

        RCLONE_PASSWORD_COMMAND = "pass blackr0ck/rclone";
      };
    };
  };
}
