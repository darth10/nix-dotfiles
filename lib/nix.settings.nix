{...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
    };
  };
}
