{...}: {
  programs.mise = {
    enable = true;

    globalConfig = {
      tools = {
        usage = "latest";
      };
      settings = {
        experimental = true;
      };
    };
  };
}
