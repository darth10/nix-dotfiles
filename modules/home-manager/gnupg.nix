{...}: {
  flake.modules.homeManager.gnupg = {
    pkgs,
    config,
    ...
  }: {
    home = {
      packages = [pkgs.gnupg];
      sessionVariables.GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    };
  };
}
