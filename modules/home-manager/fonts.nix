{pkgs, ...}: {
  home.packages = with pkgs; [
    fontconfig
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  fonts.fontconfig.enable = true;
}
