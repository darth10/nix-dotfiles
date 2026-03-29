{
  self,
  inputs,
  ...
}: {
  flake.modules.homeManager.maelstrom = {pkgs, ...}: let
    dotfilesDir = (self.settings.getDirs pkgs).dotfiles;
  in {
    home = {
      sessionVariables = {
        TERM = "xterm";
      };

      sessionPath = ["/nix/var/nix/profiles/default/bin/"];

      activation.cloneDotfiles = inputs.home-manager.lib.hm.dag.entryBefore ["writeBoundary"] ''
        if [[ ! -d ${dotfilesDir} ]]; then
          run ${pkgs.git}/bin/git clone https://github.com/darth10/nix-dotfiles.git ${dotfilesDir}
        fi
      '';
    };
  };
}
