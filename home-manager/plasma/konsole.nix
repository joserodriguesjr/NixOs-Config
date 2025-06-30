# $ nix-channel --add https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz plasma-manager
# $ nix-channel --update plasma-manager

{ pkgs, ...}:
{
  imports = [
    <plasma-manager/modules>
  ];

  programs.plasma = {
    enable = true;

    configFile."konsolerc" = {
      "Desktop Entry" = {
        DefaultProfile = "zsh.profile";
      };
    };

    dataFile."konsole/zsh.profile" = {
      "General" = {
        Name = "Zsh";
        Command = "${pkgs.zsh}/bin/zsh";
        Translucency = true;
      };

      "Appearance" = {
        ColorScheme = "Transparent";
      };
    };

    dataFile."konsole/Transparent.colorscheme" = {
      "Background" = {
        Color = "0,0,0"; # black
        Transparency = 40; # 0–255; lower = more transparent
      };

      "Foreground" = {
        Color = "255,255,255";
      };

      "General" = {
        Blur = true;
        Opacity = 0.75;
        ColorRandomization=false;
        #FillStyle=Tile;

        #Wallpaper=;
        #WallpaperFlipType=NoFlip;
        #WallpaperOpacity=1;

        Description = "Transparent NixOS";
        ColorScheme = "Transparent";
      };
    };
  };

}