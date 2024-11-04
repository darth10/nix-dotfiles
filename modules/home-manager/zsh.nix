{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      zsh
      zsh-vi-mode
      oh-my-zsh
      starship
      atuin
    ];

    file = {
      # TODO use mkOutOfStoreSymlink
      ".config/starship.toml".source = ../starship/starship.toml;
    };

    # TODO import from dotfiles-majaro/.aliases
    shellAliases = {
      gits = "git status -s";
      gitd = "git diff";
      gita = "git add";
      gitc = "git commit";
      gitca = "git commit --amend";
      gitl = "git log";

      nho = "nh os";
      nhob = "nh os build";
      nhos = "nh os switch --ask";

      nhh = "nh home";
      nhhc = ''echo "$(nix eval --impure --raw --expr builtins.currentSystem).darth10"'';
      nhhb = "nh home build -c $(nhhc)";
      nhhs = "nh home switch -b backup --ask -c $(nhhc)";
      nhhg = "echo 'generation:' $(home-manager generations | head -n 1 | cut -d' ' -f 5,6,7)";
    };
  };

  # TODO import/convert .zshrc from dotfiles
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      history.path = "${config.xdg.dataHome}/zsh/zsh_history";

      initExtra = ''
        ZVM_INIT_MODE=sourcing

        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
      '';

      oh-my-zsh = {
        enable = true;

        plugins = [
          "aws"
          "command-not-found"
          "docker"
          "docker-compose"
          "git"
          "history"
          "lein"
          "kubectl"
          "mise"
          "sudo"
        ];
      };
    };

    readline = {
      enable = true;
      extraConfig = ''
        set editing-mode vi
      '';
    };

    starship.enable = true;

    atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = ["--disable-up-arrow"];

      settings = {
        enter_accept = false;
        inline_height = 15;
        style = "compact";
        keymap_mode = "vim-insert";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
