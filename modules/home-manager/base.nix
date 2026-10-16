{self, ...}: {
  flake.modules.homeManager.base = {pkgs, ...}: {
    xdg.enable = true;

    programs.home-manager.enable = true;
    manual.manpages.enable = false;

    home = {
      username = self.settings.username;
      homeDirectory = (self.settings.getDirs pkgs).home;
      preferXdgDirectories = true;
    };
  };
}
