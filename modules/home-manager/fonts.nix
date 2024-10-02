{pkgs, ...}: {
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    fontconfig
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  fonts.fontconfig.enable = true;
}
