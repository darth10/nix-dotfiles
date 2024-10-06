{
  config,
  pkgs,
  lib,
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
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  imports = [
    ./git.nix
    ./zsh.nix
    ./fonts.nix
  ];

  home.username = username;
  home.homeDirectory = homeDir;

  home.packages = with pkgs; [
    nh
    nvd

    nano
    gnupg
    htop
    rlwrap
    tree

    fd
    (ripgrep.override {withPCRE2 = true;})

    alejandra
  ];

  home.file = {
    ".ssh/config".source = ../ssh/config;
    "${configDir}/kitty".source = ../kitty;
    "${configDir}/htop/htoprc".text = ''
      color_scheme=1
    '';
    "${configDir}/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
    "${configDir}/doom".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/doom";
  };

  home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [[ ! -d ${configDir}/emacs ]]; then
      echo "Cloning Doom Emacs"
      ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs.git ${configDir}/emacs/
    fi
  '';

  programs.home-manager.enable = true;
  programs.htop.enable = true;

  # These values are store in ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # Sessions vars and path require logout for correct activation.
  home.sessionVariables = {
    FLAKE = dotfilesDir;
    EDITOR = "emacsclient -t -a ''";
    DOOMDIR = "${configDir}/doom";
    EMACSDIR = "${configDir}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";

    PASSWORD_STORE_DIR = "${homeDir}/Cloud/pass";
    PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
  };
  home.sessionPath = ["${configDir}/emacs/bin"];
}
