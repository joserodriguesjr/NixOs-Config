# ls -d /nix/store/*-linux-firmware-*/lib/firmware/ <- real lib/firmware path
  # ls <PASTE_PATH_HERE>/iwlwifi*
  # ls $(cat /sys/module/firmware_class/parameters/path)
  # /etc/modprobe.d/firmware.conf <- firmware path is here (symlink)
  # enableRedistributableFirmware causes linux-firmware and others to be added to the hardware.firmware
  # hardware.enableRedistributableFirmware = true;
  # hardware.enableAllFirmware = true;
  # example
  # hardware.firmware = [
  #   (
  #     let
  #       driverPkg = builtins.fetchTarball {
  #         url = "https://mpow.s3-us-west-1.amazonaws.com/mpow_MPBH456AB_driver+for+Linux.tgz";
  #         sha256 = "0mq2jq0mhmh2mjxhbr74hgv63ji77n2vn4phfpg55x7j9kixjs1a";
  #       };
  #     in
  #     pkgs.runCommandNoCC "firmware-rtl8761b" { } ''
  #       mkdir -p $out/lib/firmware/rtl_bt
  #       cp ${driverPkg}/rtkbt-firmware/lib/firmware/rtlbt/rtl8761b_config $out/lib/firmware/rtl_bt/rtl8761b_config.bin
  #       cp ${driverPkg}/rtkbt-firmware/lib/firmware/rtlbt/rtl8761b_fw $out/lib/firmware/rtl_bt/rtl8761b_fw.bin
  #     ''
  #   )
  # ];
  # hardware.firmware = [ pkgs.linux-firmware ];