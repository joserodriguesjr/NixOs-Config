# https://www.playstation.com/en-us/support/hardware/ps3/system-software/
# https://rpcs3.net/quickstart
# Roms: https://romsfun.com/roms/ps3

# Remove 30 fps cap: https://www.youtube.com/watch?v=jNoyo1XXAus&pp=ygUGI3IweDFj

{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rpcs3 ];
}
