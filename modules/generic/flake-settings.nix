{
  self,
  lib,
  ...
}: {
  options.flake.settings = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "darth10";
    };
    editor = lib.mkOption {
      type = lib.types.str;
      default = "vim";
    };
  };

  config.flake.settings.getDirs = pkgs: rec {
    home =
      if pkgs.stdenv.isDarwin
      then "/Users/${self.settings.username}"
      else "/home/${self.settings.username}";
    dotfiles = "${home}/.nix-dotfiles";
    homeModules = "${dotfiles}/modules/home-manager";
  };
}
