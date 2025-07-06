#boot.kernelModules = [ "nvidia" ];
#hardware.opengl.enable = true;
#hardware.opengl.driSupport32Bit = true;

#environment.systemPackages = with pkgs; [
#  lutris
#  wineWowPackages.staging   # or .full if you want everything
#  winetricks
#  vulkan-loader
#  vulkan-tools
#  libpulseaudio
#];
