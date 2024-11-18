{
  config,
  pkgs,
  ...
}: {
  enable = true;
  lfs.enable = true;
  userName = "SakuyaAshford";
  userEmail = "Sakuya3rd+dev@proton.me";

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}

