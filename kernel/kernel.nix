{ pkgs, ... }:

{
  imports = [
    ./docker/docker.nix

    ./gaming/pcsx2.nix
    ./gaming/rpcs3.nix
    ./gaming/shadps4.nix
    ./gaming/steam.nix
    ./gaming/stream.nix

    ./hardware/bluetooth.nix
    ./hardware/boot.nix
    ./hardware/file-system.nix
    ./hardware/gpu.nix
    ./hardware/network.nix
  ];

  # System-Wide Apps (Without configuration or documentation)
  environment.systemPackages = with pkgs; [
    # ───── Utilities ─────
    qbittorrent-enhanced # Torrent client with an enhanced user interface and features
    discord # Chat and voice platform used especially by gaming communities
    bitwarden-desktop # Secure open-source password manager
    microsoft-edge # Chromium-based web browser by Microsoft
    bottles # Easy-to-use GUI for managing Wine environments
    gparted # GUI partition manager

    # ───── Gaming ─────
    # https://www.protondb.com/
    mangohud # Vulkan/OpenGL overlay for monitoring FPS, temps, CPU/GPU usage
    gamemode # Optimizes Linux system performance while gaming
    protonup-qt # GUI for installing and managing Proton-GE and Wine-GE versions
    heroic # Open-source game launcher for Epic, GOG, and Amazon libraries

    # ───── Graphics Drivers (Essential) ─────
    nvidia-vaapi-driver # Enables VA-API hardware video decoding on NVIDIA GPUs
    vulkan-loader # Vulkan runtime loader (libvulkan.so); needed to run Vulkan apps
    mesa # OpenGL implementation; required even with NVIDIA drivers
    vulkan-tools # Diagnostic tools like `vulkaninfo` and sample Vulkan apps

    # ───── Graphics Drivers (Optional / Dev) ─────
    vulkan-headers # C/C++ header files to compile Vulkan applications
    vulkan-validation-layers # Development tools to detect Vulkan API misusage

    # Optional: Additional wine environments (commented out)
    # lutris                 # Unified game launcher supporting Wine, emulators, and native games
    # wine                   # Compatibility layer for running Windows apps
    # winetricks             # Script to install libraries and tweaks inside Wine prefixes
  ];
}
