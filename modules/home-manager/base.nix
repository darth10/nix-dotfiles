{self, ...}: {
  flake.modules.homeManager.base = {pkgs, ...}: {
    nix.package = pkgs.nix;
    xdg.enable = true;

    programs.home-manager.enable = true;

    home = {
      username = self.settings.username;
      homeDirectory = (self.settings.getDirs pkgs).home;
      preferXdgDirectories = true;
    };
  };
}
