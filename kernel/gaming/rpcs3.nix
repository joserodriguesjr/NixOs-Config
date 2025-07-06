# https://www.playstation.com/en-us/support/hardware/ps3/system-software/
# Roms: https://romsfun.com/roms/ps3 

{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rpcs3 ];
}
