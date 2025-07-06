{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "joserodriguesjr";
    userEmail = "joseluisrjunior@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      credential.helper = "cache --timeout=6000";
    };

    aliases = {
      s = "status -sb";
    };
  };
}
