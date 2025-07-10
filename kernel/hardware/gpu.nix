# https://nixos.wiki/wiki/Nvidia
# https://nixos.wiki/wiki/CUDA
# https://medium.com/@notquitethereyet_/gaming-on-nixos-%EF%B8%8F-f98506351a24

# nvidia-offload %command%

# __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia %command%
# __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only %command%

{ config, pkgs, ... }:

{

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau # Translates VA-API calls to VDPAU (useful on NVIDIA)
      libvdpau-va-gl # Translates VDPAU to VA-API using OpenGL backend (enables HW decode on some setups)
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  #  services.xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Same as production
    # package = config.boot.kernelPackages.nvidiaPackages.production; # Latest production driver

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Lets you use `nvidia-offload %command%` in steam
      };
      # In sync mode, rendering is completely delegated to the dGPU, while the iGPU only displays the rendered framebuffers copied from the dGPU.
      sync.enable = false;

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      # amdgpuBusId = "PCI:0:0:0"; For AMD GPU
    };

  };
}
