{...}: {
  flake.modules.nixos.starf0rge = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      google-chrome
      spotify
      transmission_4
      transmission_4-gtk
      usbimager
      veracrypt

      # LaTeX
      (texlive.combine
        {
          inherit
            (texlive)
            scheme-small
            amsmath
            minted
            isodate
            textpos
            titlesec
            ;
        })

      # LSP servers
      clojure-lsp
      texlab

      # Games
      tt
      openra
      openttd
    ];
  };
}
