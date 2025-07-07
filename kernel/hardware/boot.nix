{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel modules required in the initrd to boot
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "usbhid"
  ];
  # boot.initrd.availableKernelModules = [
  #   "nvme" # NVMe SSD
  #   "xhci_pci" # USB 3.x controller
  #   "r8169" # Realtek 2.5GbE Ethernet
  #   "i915" # Intel integrated graphics
  #   "nvidia" # Dedicated NVIDIA GPU (proprietary driver)
  #   "snd_hda_intel" # Audio (Intel and NVIDIA HDMI)
  #   "iwlwifi" # Intel Wi-Fi
  #   "ahci" # SATA controllers (fallback)
  #   "thunderbolt" # Thunderbolt support (eGPU, docks)
  #   "usbhid" # USB keyboard/mouse
  #   "uas" # USB 3.0 storage devices using the USB Attached SCSI Protocol.
  #   "usb_storage" # USB drives and external disks
  #   "sd_mod" # SCSI/SATA/USB disk support
  # ];

  # Kernel modules to load in the second stage of boot
  boot.kernelModules = [ "kvm-intel" ];
  # boot.kernelModules = [
  #   "btusb" # Bluetooth via USB
  #   "uvcvideo" # Integrated webcam
  #   "intel-vsec" # Intel telemetry (power management)
  #   "mei_me" # Intel MEI (sensors, AMT, etc.)
  #   "processor_thermal_device_pci" # CPU thermal control
  #   "i2c_i801" # SMBus controller (sensors and communication)
  #   "spi_intel_pci" # SPI support (firmware/sensors)
  #   "intel_lpss_pci" # Low Power Subsystem (I2C/SPI)
  #   "nvidia" # Main NVIDIA GPU driver
  #   "nvidia_drm" # DRM/KMS integration
  #   "nvidia_modeset" # NVIDIA video modes support
  #   "nvidia_uvm" # Unified Virtual Memory (CUDA)
  #   "kvm-intel" # Hardware virtualization (Intel VT-x)
  # ];

  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  #   # boot.extraModprobeConfig = ''
  #   #   options snd_hda_intel probe_mask=1
  #   # '';
  # }
}
