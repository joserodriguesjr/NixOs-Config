{ config, pkgs, ... }:

{
 environment.systemPackages = [
    pkgs.qbittorrent-enhanced
  ];
}