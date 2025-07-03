{ config, pkgs, ... }:

{
  imports = [
    ./docker/docker.nix

    ./emulator/pcsx2.nix
    ./emulator/rpcs3.nix
    
    ./hardware/bluetooth.nix

    ./security/bitwarden.nix
  ];
}
