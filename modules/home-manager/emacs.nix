{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    programs.doom-emacs = {
      enable = lib.mkEnableOption "Enable Doom Emacs";
      dotfilesDir = lib.mkOption {type = lib.types.str;};
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (!config.programs.doom-emacs.enable) {
      home.sessionVariables = {
        EDITOR = "vim";
        VISUAL = "vim";
      };
    })
    (lib.mkIf config.programs.doom-emacs.enable
      {
        home = let
          dotfilesDir = config.programs.doom-emacs.dotfilesDir;
          configDir = config.xdg.configHome;
        in {
          file = {
            "${configDir}/doom".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/doom";
          };

          activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
            if [[ ! -d ${configDir}/emacs ]]; then
              echo "Cloning Doom Emacs"
              ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs.git ${configDir}/emacs/
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
      })
  ];
}
