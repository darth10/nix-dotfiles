{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "darth10";
  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/darth10"
    else "/home/darth10";
  dotfilesDirectory = homeDirectory + "/.nix-dotfiles";
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
  home.homeDirectory = homeDirectory;

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

    nil
    alejandra
  ];

  home.file = {
    ".ssh/config".source = ../ssh/config;
    ".config/kitty".source = ../kitty;
    ".config/htop/htoprc".text = ''
      color_scheme=1
    '';
    ".config/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
  };

  home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [[ ! -d ${config.xdg.configHome}/emacs ]]; then
      echo "Cloning Doom Emacs"
      ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs.git ${config.xdg.configHome}/emacs/
    fi
    if [[ ! -d ${config.xdg.configHome}/doom ]]; then
      echo "Linking Doom Emacs configuration"
      ln -s ${dotfilesDirectory + "/modules/doom"} ${config.xdg.configHome}/doom
    fi
  '';

  programs.home-manager.enable = true;
  programs.htop.enable = true;

  # These values are store in ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # Sessions vars and path require logout for correct activation.
  home.sessionVariables = {
    FLAKE = dotfilesDirectory;
    EDITOR = "emacsclient -t -a ''";
    DOOMDIR = "${config.xdg.configHome}/doom";
    EMACSDIR = "${config.xdg.configHome}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";

    PASSWORD_STORE_DIR = "${homeDirectory}/Cloud/pass";
    PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
  };
  home.sessionPath = ["${config.xdg.configHome}/emacs/bin"];
}
