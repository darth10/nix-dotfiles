{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      cmake
      dig.dnsutils
      direnv
      emacs
      fastfetch
      foliate
      gcc
      google-chrome
      gnumake
      guile
      # vdhcoapp
      kitty
      libtool
      lshw
      pssh
      sox
      spotify
      transmission_4
      transmission_4-gtk
      usbimager
      unzip
      veracrypt
      vlc
      wl-clipboard

      # Packages needed for remote editing
      git
      gnupg
      fd
      (ripgrep.override {withPCRE2 = true;})

      # Password Store
      (pass.withExtensions (ext:
        with ext; [
          pass-audit
        ]))
      pass

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
      bash-language-server
      clojure-lsp
      nil
      texlab

      # Games
      tt
      openra
      openttd
    ]
    ++ (import ../../lib/nh.nix {inherit pkgs;});

  environment.gnome.excludePackages = with pkgs; [
    atomix
    epiphany
    geary
    gedit
    gnome-characters
    gnome-maps
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori
    iagno
    tali
    totem
    usbutils
  ];
}
