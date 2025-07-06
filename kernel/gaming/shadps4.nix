# Roms
# https://dlpsgame.com/category/ps4/
# https://romsever.com/ps4-roms/
# https://romsfun.com/roms/playstation-4

{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ./shadps4.overlay.nix) ];

  environment.systemPackages = with pkgs; [
    shadps4-v07 # Fixed on version 0.7 to install packages
    shadps4 # Latest version for playing
  ];
}
