{ config, pkgs, ... }:

{
  # imports = [ ];

  virtualisation.docker = {
    enable = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

}
