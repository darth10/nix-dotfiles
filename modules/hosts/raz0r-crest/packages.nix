{...}: {
  flake.modules.nixos.raz0r-crest = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gimp
      gparted
      zoom-us
    ];
  };
}
