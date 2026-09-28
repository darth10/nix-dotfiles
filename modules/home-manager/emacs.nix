{self, ...}: {
  flake.modules.homeManager.emacs = {
    config,
    pkgs,
    ...
  }: {
    home = let
      dotfilesDir = (self.settings.getDirs pkgs).dotfiles;
      doomDir = "${dotfilesDir}/doom.d";
      emacsDir = "${dotfilesDir}/emacs.d";
      configDir = config.xdg.configHome;
      doomLocalDir = "${config.xdg.dataHome}/doom";
    in {
      file = {
        "${configDir}/doom".source = config.lib.file.mkOutOfStoreSymlink doomDir;
        "${configDir}/emacs".source = config.lib.file.mkOutOfStoreSymlink emacsDir;
        "${emacsDir}/.local".source = config.lib.file.mkOutOfStoreSymlink doomLocalDir;
      };

      packages = with pkgs; [
        aspell
        aspellDicts.en
        python312Packages.grip
      ];

      shellAliases.e = "emacsclient -t -a=";

      # These values are store in ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      # Sessions vars and path require logout for correct activation.
      sessionVariables = {
        DOOMDIR = "${configDir}/doom";
        EMACSDIR = "${configDir}/emacs";
        DOOMLOCALDIR = doomLocalDir;
        GRIPHOME = "${config.xdg.cacheHome}/grip";

        EDITOR = "e";
        VISUAL = "e";
      };

      sessionPath = ["${configDir}/emacs/bin"];
    };
  };
}
