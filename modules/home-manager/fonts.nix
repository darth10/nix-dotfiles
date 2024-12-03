{pkgs, ...}: {
  home.packages = with pkgs; [
    fontconfig
    nerd-fonts.fira-code
  ];

  fonts.fontconfig.enable = true;
}
