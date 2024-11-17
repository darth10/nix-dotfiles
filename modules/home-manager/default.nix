{
  config,
  pkgs,
  ...
}: let
  username = "darth10";
  homeDir =
    if pkgs.stdenv.isDarwin
    then "/Users/darth10"
    else "/home/darth10";
  dotfilesDir = homeDir + "/.nix-dotfiles";
  configDir = config.xdg.configHome;
in {
  nix.package = pkgs.nix;
  xdg.enable = true;

  imports = [
    ../../lib/nix.settings.nix
    ./packages.nix
    ./git.nix
    ./emacs.nix
    ./zsh.nix
    ./mise.nix
    ./fonts.nix
  ];

  home = {
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05";

    username = username;
    homeDirectory = homeDir;
    preferXdgDirectories = true;

    file = {
      ".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/ssh/config";
      "${configDir}/kitty".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/kitty";
      "${configDir}/htop/htoprc".text = ''
        color_scheme=1
      '';
      "${configDir}/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=1
      '';
      "${configDir}/clojure/deps.edn".text = ''
        {
          :mvn/local-repo "${config.xdg.dataHome}/mvn/"

          :aliases {
            ;; Add cross-project aliases here
          }
        }'';
    };

    # These values are store in ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # Sessions vars and path require logout for correct activation.
    sessionVariables = {
      FLAKE = dotfilesDir;

      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      PASSWORD_STORE_DIR = "${homeDir}/Cloud/pass";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    };
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;

    zsh = {
      inherit dotfilesDir;
    };

    doom-emacs = {
      inherit dotfilesDir;
      enable = true;
    };
  };
}
