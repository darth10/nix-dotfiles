{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) optionals;
in {
  home.packages = with pkgs;
    [
      comma
      nano
      gnupg
      htop
      rlwrap
      kubectl

      fd
      (ripgrep.override {withPCRE2 = true;})

      alejandra
    ]
    ++ (import ../../lib/nh.nix {inherit pkgs;})
    ++ optionals pkgs.stdenv.isLinux []
    ++ optionals pkgs.stdenv.isDarwin [];
}
