{ config, pkgs, ... }:

{
  imports = [
    ./docker/docker.nix

    ./gaming/pcsx2.nix
    ./gaming/rpcs3.nix
    ./gaming/steam.nix

    ./hardware/bluetooth.nix
    ./hardware/gpu.nix
  ];

  # System-Wide Apps (Without configuration or documentation)
  environment.systemPackages = with pkgs; [
    # Utils
    qbittorrent-enhanced
    discord
    bitwarden-desktop

    # Gaming
    mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more.
    protonup-qt # Install Wine and Proton-based Compatibility Tools
    lutris # Play all your games on Linux
    bottles # Run Windows software on Linux 
    heroic # Open Source Launcher for GOG, Epic Games and Amazon Games
  ];
}
