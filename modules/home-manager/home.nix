{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "darth10";
  homeDirectory = "/home/darth10";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nh
    nvd

    nano
    emacs
    gnupg
    git
    delta
    zsh
    oh-my-zsh
    starship
    atuin
    htop
    rlwrap
    tree

    fd
    (ripgrep.override {withPCRE2 = true;})

    emacs-all-the-icons-fonts
    fontconfig
    (nerdfonts.override {fonts = ["FiraCode"];})
    nil
    alejandra

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/starship.toml".source = ../starship/starship.toml;
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
      ln -s ${homeDirectory + "/.nix-dotfiles/modules/doom"} ${config.xdg.configHome}/doom
    fi
  '';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/darth10/etc/profile.d/hm-session-vars.sh
  #
  # Sessions vars and path require logout for correct activation.
  home.sessionVariables = {
    FLAKE = "${homeDirectory}/.nix-dotfiles/";
    EDITOR = "emacsclient -t -a ''";
    DOOMDIR = "${config.xdg.configHome}/doom";
    EMACSDIR = "${config.xdg.configHome}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";

    PASSWORD_STORE_DIR="${homeDirectory}/Cloud/pass";
    PASSWORD_STORE_ENABLE_EXTENSIONS="true";
  };

  home.sessionPath = ["${config.xdg.configHome}/emacs/bin"];

  # TODO use .aliases file with .zshrc
  home.shellAliases = {
    gits = "git status -s";
    gitd = "git diff";
    gita = "git add";
    gitc = "git commit";
    gitca = "git commit --amend";
    gitl = "git log";

    nho  = "nh os";
    nhob = "nh os build";
    nhos = "nh os switch --ask";

    nhh  = "nh home";
    nhhb = "nh home build";
    nhhs = "nh home switch -b backup --ask";
    nhhg = "echo 'generation:' $(home-manager generations | head -n 1 | cut -d' ' -f 5,6,7)";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # TODO use .gitconfig from dotfiles, move to .config/git/config
  programs.git = {
    enable = true;

    userName = "Akhil Wali";
    userEmail = "akhil.wali.10@gmail.com";

    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "CBA0458B682A8544";

      github.user = "darth10";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };

    delta = {
      enable = true;
      options = {
        feature = "theme";
        navigate = true;
        theme = {
          dark = true;
          syntax-theme = "Nord";
        };
      };
    };
  };

  # TODO use .zshrm from dotfiles
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;

      plugins = [
        "command-not-found"
        "git"
        "history"
        "sudo"
      ];
    };
  };

  programs.starship.enable = true;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = ["--disable-up-arrow"];

    settings = {
      enter_accept = false;
      inline_height = 15;
      style = "compact";
    };
  };

  programs.htop = {
    enable = true;
  };
}
