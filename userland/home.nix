{ config, pkgs, ... }:

{
  imports = [
    ./plasma/konsole.nix
    
    ./programs/social/discord.nix

    ./programs/coding/git.nix
    ./programs/coding/vscode.nix
    ./programs/coding/zsh.nix
  ];

  #home.username = "runior";
  #home.homeDirectory = "/home/runior";
  home.stateVersion = "25.05";  # Set to match your system version

  home.packages = with pkgs; [
    home-manager
  ];
}
