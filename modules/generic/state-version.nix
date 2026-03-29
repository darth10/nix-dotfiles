{...}: {
  flake.modules.nixos.stateVersion = {
    system.stateVersion = "26.05";
  };
  flake.modules.homeManager.stateVersion = {
    home.stateVersion = "26.05";
  };
}
