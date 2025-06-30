{ config, pkgs, ... }:

{
  programs.plasma.enable = true;

  # Enable the KWin compositor
  services.xserver.windowManager.kde5.compositor.enable = true;

  # Enable blur behind windows (KWin effect)
  services.xserver.windowManager.kde5.compositor = {
    effects = {
      blur = {
        enable = true;
        background = true;  # Enable blur behind windows
      };
    };
  };

  # Ensure the necessary graphical settings for transparency are enabled
  services.xserver.displayManager.startx.defaultSession = "plasma";

  # Additional graphical performance settings if you want (for some systems)
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
}
