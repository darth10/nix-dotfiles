{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    delta
  ];

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
}
