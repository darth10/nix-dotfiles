{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    services.pcloud = {
      enable = lib.mkEnableOption "Enable pCloud";
    };
  };

  config = lib.mkIf config.services.pcloud.enable {
    home = {
      packages = [pkgs.pcloud];

      file = {
        "${config.xdg.configHome}/autostart/pcloud.desktop".text = ''
          [Desktop Entry]
          Name=pcloud
          Type=Application
          Exec=${pkgs.pcloud}/bin/pcloud
          StartupNotify=false
          Terminal=false
        '';
      };
    };
  };
}
