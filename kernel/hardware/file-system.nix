{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/03d1e2f8-646b-40a8-a486-77b92bc256ac";
    fsType = "ext4";
  };

  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/3dcbbb22-78ee-46b3-b36d-4daee03af670";
    fsType = "ext4";
    neededForBoot = false;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B934-4EA3";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/86d200ca-f473-4b74-a65e-fae9a6e2edfc"; }
    # size = 8 * 1024; # 8GB
  ];
  # swapDevices = lib.mkForce [ ]; # Remove all swap devices
}
