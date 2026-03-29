{
  self,
  lib,
  ...
}: let
  nh = {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 5d --keep 3";
    };
  };
in {
  flake.modules.nixos.nh = nh;

  flake.modules.homeManager.nh = {pkgs, ...}:
    lib.mkMerge [
      nh
      {
        home = {
          packages = [
            pkgs.nvd
          ];
          shellAliases = {
            nho = "nh os";
            nhog = "nh os info";
            nhob = "nh os build";
            nhos = "nh os switch --ask";

            nhh = "nh home";
            nhhb = "nh home build -c $USER";
            nhhs = "nh home switch -b backup --ask -c $USER";
            nhhg = "home-manager generations";
          };

          sessionVariables = {
            NH_FLAKE = (self.settings.getDirs pkgs).dotfiles;
          };
        };
      }
    ];
}
