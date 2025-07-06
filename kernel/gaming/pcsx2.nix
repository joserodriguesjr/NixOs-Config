# https://raw.githubusercontent.com/xlenore/ps2-covers/main/covers/default/${serial}.jpg
# Covers: https://github.com/xlenore/ps2-covers
# Roms: https://romsfun.com/roms/playstation-2

{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.pcsx2 ];
}
