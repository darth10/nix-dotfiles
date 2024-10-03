{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
    starship
    atuin
  ];

  home.file = {
    ".config/starship.toml".source = ../starship/starship.toml;
  };

  # TODO import from dotfiles-majaro/.aliases
  home.shellAliases = {
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

  # TODO import/convert .zshrc from dotfiles
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;

        plugins = [
          "command-not-found"
          "git"
          "history"
          "sudo"
          "mise"
        ];
      };
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
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
