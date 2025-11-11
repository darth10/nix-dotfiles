{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    vista-fonts
  ];
}
