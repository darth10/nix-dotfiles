{...}: {
  flake.modules.homeManager.mise = {
    programs.mise = {
      enable = true;

      globalConfig = {
        tools = {
          usage = "latest";
          babashka = "latest";
          java = "corretto-21.0.13.0.11";
          node = "lts";
        };
        settings = {
          experimental = true;
        };
      };
    };
  };
}
