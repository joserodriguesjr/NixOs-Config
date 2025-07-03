{ config, pkgs, ... }:

{
  imports = [
    ./docker/docker.nix

    ./hardware/bluetooth.nix
  ];
}
