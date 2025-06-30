{ config, pkgs, ... }:

{
  imports = [
    ./plasma/konsole.nix
    
    ./programs/git.nix
    ./programs/vscode.nix
    ./programs/zsh.nix
  ];


  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  #home.username = "runior";
  #home.homeDirectory = "/home/runior";
  home.stateVersion = "25.05";  # Set to match your system version

  programs.home-manager.enable = true;
}
