{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    delta
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Akhil Wali";
        email = "akhil.wali.10@gmail.com";
      };

      commit.gpgsign = true;
      user.signingkey = "CBA0458B682A8544";

      github.user = "darth10";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      feature = "theme";
      navigate = true;
      theme = {
        dark = true;
        syntax-theme = "Nord";
      };
    };
  };
}
