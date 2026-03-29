{...}: {
  flake.modules.homeManager.vim = {...}: {
    home.sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
