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
      manix
      vim
      gnupg
      htop
      rlwrap
      kubectl

      fd
      (ripgrep.override {withPCRE2 = true;})
      jq

      alejandra
    ]
    ++ (import ../../lib/nh.nix {inherit pkgs;})
    ++ optionals pkgs.stdenv.isLinux []
    ++ optionals pkgs.stdenv.isDarwin [];
}
