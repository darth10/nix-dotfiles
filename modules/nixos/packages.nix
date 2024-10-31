{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      dig.dnsutils
      direnv
      emacs
      foliate
      google-chrome
      vdhcoapp
      kitty
      manix
      pssh
      mise
      neofetch
      spotify
      transmission_4
      transmission_4-gtk
      unzip
      veracrypt
      vlc

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

      # LSP servers
      bash-language-server
      clojure-lsp
      nil

      # Games
      openra
      openttd
    ]
    ++ (import ../../lib/nh.nix {inherit pkgs;});
}
