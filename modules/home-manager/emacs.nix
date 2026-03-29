{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.emacs = {
    config,
    pkgs,
    ...
  }: {
    home = let
      homeModulesDir = (self.settings.getDirs pkgs).homeModules;
      configDir = config.xdg.configHome;
      emacsConfigDir = "${configDir}/emacs";
    in {
      file = {
        "${configDir}/doom".source = config.lib.file.mkOutOfStoreSymlink "${homeModulesDir}/doom";
      };

      activation.installDoomEmacs = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [[ ! -d ${emacsConfigDir} ]]; then
          run echo "Cloning Doom Emacs into ${emacsConfigDir}"
          run --quiet ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs.git ${emacsConfigDir}
        fi
      '';

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
        DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
        GRIPHOME = "${config.xdg.cacheHome}/grip";

        EDITOR = "e";
        VISUAL = "e";
      };

      sessionPath = ["${configDir}/emacs/bin"];
    };
  };
}
