{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "darth10";
  home.homeDirectory = "/home/darth10";

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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
   pkgs.emacs
   pkgs.delta
   pkgs.zsh
   pkgs.oh-my-zsh
   pkgs.starship
   pkgs.atuin
   pkgs.htop

   pkgs.fd
   (pkgs.ripgrep.override {withPCRE2 = true;})

   pkgs.emacs-all-the-icons-fonts
   pkgs.fontconfig
   (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })

   pkgs.nixfmt-classic
   pkgs.nil

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/starship.toml".source = ~/projects/dotfiles/modules/starship/starship.toml;
  };

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
    # EDITOR = "emacs";
    DOOMDIR = "${config.xdg.configHome}/doom";
    EMACSDIR = "${config.xdg.configHome}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
  };

  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  home.shellAliases = {
    gits = "git status -s";
    gitd = "git diff";
    gita = "git add";
    gitc = "git commit";
    gitca = "git commit --amend";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Akhil Wali";
    userEmail = "akhil.wali.10@gmail.com";
  };

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

  programs.starship = {
    enable = true;
  };

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
    settings = {
      color_scheme = 1;
    };
  };
}
