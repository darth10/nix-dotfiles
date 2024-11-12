{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    programs.zsh.dotfilesDir = lib.mkOption {type = lib.types.str;};
  };

  config = {
    home = let
      dotfilesDir = config.programs.zsh.dotfilesDir;
    in {
      packages = with pkgs; [
        fzf
      ];

      file = {
        ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/starship/starship.toml";
      };

      shellAliases = {
        nho = "nh os";
        nhob = "nh os build";
        nhos = "nh os switch --ask";

        nhh = "nh home";
        nhhc = ''echo "$(nix eval --impure --raw --expr builtins.currentSystem).darth10"'';
        nhhb = "nh home build -c $(nhhc)";
        nhhs = "nh home switch -b backup --ask -c $(nhhc)";
        nhhg = "echo 'generation:' $(home-manager generations | head -n 1 | cut -d' ' -f 5,6,7)";

        icat = "kitty icat";
        pnoise = "play -n synth pinknoise";
        wnoise = "play -n synth pinknoise";
      };

      sessionVariables = {
        SHOW_AWS_PROMPT = "false";
      };
    };

    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableCompletion = false; # Completion is setup using zinit
        history.path = "${config.xdg.dataHome}/zsh/zsh_history";
        # zprof.enable = true;

        initExtraFirst = ''
          [[ $TERM = "tramp" ]] && unsetopt zle && PS1='$ ' && return
          [[ $TERM = "dumb" ]] && unset zle_bracketed_paste && unsetopt zle && PS1='$ '
        '';

        initExtra = ''
          if [[ $OSTYPE == 'darwin'* ]] && [ -f /opt/homebrew/bin/brew ]; then
              eval "$(/opt/homebrew/bin/brew shellenv)"
          elif [[ $OSTYPE == 'linux-gnu' ]] && [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
              eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
          fi
          if command -v brew &> /dev/null ; then
              FPATH="$(brew --prefix)/share/zsh/site-functions:''${FPATH}"
          fi

          if command -v docker &> /dev/null ; then
              source <(docker completion zsh)
          fi

          if command -v mise &> /dev/null ; then
              source <(mise completion zsh)
          fi

          ZINIT_HOME="${config.xdg.dataHome}/zinit/zinit.git"
          [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
          [ ! -d $ZINIT_HOME/.git ] && ${pkgs.git}/bin/git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
          source "''${ZINIT_HOME}/zinit.zsh"

          zi snippet OMZP::sudo
          zi snippet OMZP::git
          zi snippet OMZP::aws
          zi snippet OMZP::kubectl
          zi snippet OMZP::kubectx
          zi ice as"completion"; zi snippet OMZP::lein/_lein

          ZVM_INIT_MODE=sourcing

          zinit depth"1" for \
              light-mode jeffreytse/zsh-vi-mode \
              light-mode sgpthomas/zsh-up-dir

          zi depth"1" wait lucid for \
              light-mode zsh-users/zsh-syntax-highlighting \
              light-mode Aloxaf/fzf-tab \
              light-mode zlsun/solarized-man

          zi depth"1" wait"1" lucid for \
              atload"zpcompinit; zpcdreplay" \
              light-mode zsh-users/zsh-completions

          ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
          ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
          ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
          ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
          ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
          zstyle ':completion:*' menu no
          zstyle ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(''${=''${''${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%% [# ]*}//,/ })'
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
          zstyle ':fzf-tab:*' use-fzf-default-opts yes

          source <(${pkgs.fzf}/bin/fzf --zsh)
          export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
          " --color=bg+:#073642,bg:#002b36,spinner:#2aa198,hl:#268bd2"\
          " --color=fg:#839496,header:#268bd2,info:#b58900,pointer:#2aa198"\
          " --color=marker:#2aa198,fg+:#eee8d5,prompt:#b58900,hl+:#268bd2"

          typeset -A ZSH_HIGHLIGHT_STYLES
          ZSH_HIGHLIGHT_STYLES[comment]='fg=gray'
          ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
        '';
      };

      zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };

      eza = {
        enable = true;
        icons = "auto";
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
        nix-direnv.enable = true;
      };
    };
  };
}
