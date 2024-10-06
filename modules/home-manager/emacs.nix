{
  config,
  lib,
  pkgs,
  ...
}: let
  homeDir =
    if pkgs.stdenv.isDarwin
    then "/Users/darth10"
    else "/home/darth10";
  dotfilesDir = homeDir + "/.nix-dotfiles";
  configDir = config.xdg.configHome;
in {
  home = {
    file = {
      "${configDir}/doom".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/doom";
    };

    activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [[ ! -d ${configDir}/emacs ]]; then
        echo "Cloning Doom Emacs"
        ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs.git ${configDir}/emacs/
      fi
    '';

    # These values are store in ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # Sessions vars and path require logout for correct activation.
    sessionVariables = {
      EDITOR = "emacsclient -t -a ''";
      DOOMDIR = "${configDir}/doom";
      EMACSDIR = "${configDir}/emacs";
      DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
    };
    sessionPath = ["${configDir}/emacs/bin"];
  };
}
