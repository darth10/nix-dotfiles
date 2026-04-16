{...}: {
  flake.modules.homeManager.packages = {
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
        nix-search-cli
        vim
        rlwrap
        kubectl

        fd
        (ripgrep.override {withPCRE2 = true;})
        jq

        alejandra
        rclone
      ]
      ++ optionals pkgs.stdenv.isLinux []
      ++ optionals pkgs.stdenv.isDarwin [];
  };
}
