{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    programs.nodejs.enable = lib.mkEnableOption "Enable Node.JS";
  };

  config = lib.mkIf config.programs.nodejs.enable {
    environment.systemPackages = with pkgs; [
      nodejs
    ];
    programs = {
      npm = {
        enable = true;
        npmrc = ''
          prefix=''${XDG_DATA_HOME}/npm
          cache=''${XDG_CACHE_HOME}/npm
          init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
        '';
      };
    };
  };
}
