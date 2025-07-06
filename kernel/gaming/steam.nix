{
  # https://github.com/FeralInteractive/gamemode
  programs.gamemode.enable = true;

  # https://nixos.wiki/wiki/Steam#Install
  programs.steam ={
    enable = true;
    gamescopeSession.enable = true;
  };
}
