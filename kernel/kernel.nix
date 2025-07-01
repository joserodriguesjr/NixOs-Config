{ config, pkgs, ... }:

{
  imports = [
    ./docker/docker.nix

    ./emulator/pcsx2.nix
    
    ./hardware/bluetooth.nix
  ];
}
