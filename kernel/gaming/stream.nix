# https://parsec.app/
# https://moonlight-stream.org/
# https://github.com/LizardByte/Sunshine
# https://github.com/LongerHV/nixos-configuration/blob/71667b6859588dc060c89ee9e1e645ee6a748955/modules/nixos/sunshine.nix
# https://nixos.wiki/wiki/Sunshine

# Need to open ports in router and enable UPnP

{
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = false; # Manually opening below
  };

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      47984
      47989 # Main port
      # 47990 = web UI opcional
      48010
    ];
    allowedUDPPortRanges = [
      {
        from = 47984;
        to = 48010;
      }
    ];
  };
}
