{...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
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
      kitty
      libtool
      lshw
      pssh
      sox
      unzip
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

      # LSP servers
      bash-language-server
      nil
    ];
  };
}
