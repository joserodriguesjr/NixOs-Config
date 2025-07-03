{ config, pkgs, ... }:

{
  imports = [
    ./plasma/konsole.nix
    
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/vscode.nix
    ./modules/zsh.nix
  ];

  #home.username = "runior";
  #home.homeDirectory = "/home/runior";
  home.stateVersion = "25.05";  # Set to match your system version

  home.packages = with pkgs; [
    home-manager
  ];
}
