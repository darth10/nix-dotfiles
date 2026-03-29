{...}: {
  flake.modules.homeManager.htop = {
    pkgs,
    config,
    ...
  }: {
    home.file."${config.xdg.configHome}/htop/htoprc".text = ''
      color_scheme=1
    '';
    programs.htop.enable = true;
  };
}
