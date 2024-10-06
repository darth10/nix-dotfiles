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
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  imports = [
    ./git.nix
    ./emacs.nix
    ./zsh.nix
    ./fonts.nix
  ];

  home = {
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";

    username = username;
    homeDirectory = homeDir;

    packages = with pkgs; [
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

    file = {
      ".ssh/config".source = ../ssh/config;
      "${configDir}/kitty".source = ../kitty;
      "${configDir}/htop/htoprc".text = ''
        color_scheme=1
      '';
      "${configDir}/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=1
      '';
    };

    # These values are store in ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # Sessions vars and path require logout for correct activation.
    sessionVariables = {
      FLAKE = dotfilesDir;

      PASSWORD_STORE_DIR = "${homeDir}/Cloud/pass";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    };
  };

  programs = {
    home-manager.enable = true;
    htop.enable = true;
    doom-emacs = {
      inherit dotfilesDir;
      enable = true;
    };
  };
}
