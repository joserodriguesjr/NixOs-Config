{ config, pkgs, ... }:

{
 environment.systemPackages = [
    pkgs.discord
  ];
}