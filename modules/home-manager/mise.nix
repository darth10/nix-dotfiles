{...}: {
  flake.modules.homeManager.mise = {
    programs.mise = {
      enable = true;

      globalConfig = {
        tools = {
          usage = "latest";
          babashka = "latest";
          node = "lts";
        };
        settings = {
          experimental = true;
        };
      };
    };
  };
}
