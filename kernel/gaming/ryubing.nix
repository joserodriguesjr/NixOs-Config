# Roms: https://fmhy.net/gamingpiracyguide#nintendo-roms
# Nsw2u and nxbrew

# The prod.keys file needs to match the same firmware version being installed.
# https://prodkeys.net/ryujinx-prod-keys-n12/
# https://prodkeys.net/ryujinx-firmware-v3/
# 1. Download the latest firmware key files here => https://the-prod-keys.com/ryujinx-prod-keys/
# 2. Download the official firmware here that matches the same firmware key files that you just downloaded in Step 1 => https://darthsternie.net/switch-firmwares/
# 3. Click File > Open Ryujinx Folder in Ryujinx then put the prod.keys file and title.keys file (extracted from the .zip file downloaded in Step 1) inside the system folder within the folder that opens after clicking the menu. The final path for me where I put the .keys files was /home/deck/.config/Ryujinx/system/
# 4. Click Tools > Install Firmware > Install a firmware from XCI or ZIP in Ryujinx then select the firmware .zip file that you downloaded in Step 1.

{ config, pkgs, ... }:

{
 environment.systemPackages = [
    pkgs.ryubing
#    pkgs.ryujinx
  ];
}