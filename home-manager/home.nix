{ config, pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "runior";
  home.homeDirectory = "/home/runior";
  home.stateVersion = "25.05";  # Set to match your system version

  programs.home-manager.enable = true;
}
