{ config, pkgs, ... }:

{
 environment.systemPackages = [
    pkgs.rpcs3
  ];
}