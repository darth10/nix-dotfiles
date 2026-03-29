{...}: {
  flake.modules.homeManager.pcloud = {
    config,
    lib,
    pkgs,
    ...
  }: {
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
