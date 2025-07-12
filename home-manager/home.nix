{ pkgs, ... }:

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
  home.stateVersion = "25.05"; # Set to match your system version

  home.packages = with pkgs; [
    home-manager

    nerd-fonts.fira-code
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.symbols-only
    # nerd-fonts._0xproto
    # nerd-fonts.droid-sans-mono
    # nerd-fonts.noto
    # nerd-fonts.hack
    # nerd-fonts.ubuntu
    # nerd-fonts.mplus
  ];

  fonts.fontconfig.enable = true;
}
