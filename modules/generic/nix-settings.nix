{...}: let
  settings = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
    };
  };
in {
  flake.modules.nixos.nixSettings = settings;
  flake.modules.homeManager.nixSettings = settings;
}
