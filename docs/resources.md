# Resources

## Links

### NixOS

https://mynixos.com/

Manual: https://nixos.org/manual/nixos/stable/
Forum: https://discourse.nixos.org/
Packages: https://search.nixos.org/packages?channel=25.05&size=50&sort=relevance&type=packages
Options: https://search.nixos.org/options?channel=25.05&from=0&size=50&sort=relevance&type=packages

## Home Manager

Manual: https://nixos.wiki/wiki/Home_Manager
Options: https://nix-community.github.io/home-manager/options.xhtml

https://www.reddit.com/r/NixOS/comments/1bmtjjs/what_do_you_put_in_configurationnix_and_what_in/
https://www.reddit.com/r/NixOS/comments/1bk430s/how_do_you_structure_your_modules_and_imports/

## Kernel

https://jorel.dev/NixOS4Noobs/envvars.html

### Gaming

https://nixos.wiki/wiki/Steam

https://discourse.nixos.org/t/error-the-option-programs-steam-does-not-exist/48510

https://nix-community.github.io/home-manager/options.xhtml#opt-programs.lutris.steamPackage

https://www.reddit.com/r/NixOS/comments/16mzmjf/cleanest_way_to_install_steam/

https://github.com/LongerHV/nixos-configuration/blob/71667b6859588dc060c89ee9e1e645ee6a748955/modules/nixos/sunshine.nix

bluetooth controller
https://pastebin.com/Mir1GnrH
https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/xone.nix

https://www.reddit.com/r/NixOS/comments/1ch5d2p/help_needed_to_install_and_debug_xpadneo_xbox/
https://mynixos.com/nixpkgs/option/hardware.xpadneo.enable
https://github.com/search?type=code&auto_enroll=true&q=extraModulePackages+xpadneo

https://nixos.wiki/wiki/Linux_kernel

https://www.reddit.com/r/NixOS/comments/1hdsfz0/what_do_i_have_to_do_to_make_my_xbox_controller/

#### PS2

https://pcsx2.net/
https://search.nixos.org/packages?channel=25.05&show=pcsx2&from=0&size=50&sort=relevance&type=packages&query=PCSX2
https://www.reddit.com/r/EmulationOnPC/comments/1aj96mp/how_to_download_a_pcsx2_bios_properly/
https://emulation.gametechwiki.com/index.php/Emulator_files

https://romsfun.com/roms/playstation-2/

https://www.libretro.com/
https://www.retroarch.com/

#### PS4
https://shadps4.net/
https://github.com/fufexan/nix-gaming

{ pkgs ? import <nixpkgs> {} }:
    pkgs.mkShell {
    buildInputs = [
    pkgs.clang
    pkgs.cmake
    pkgs.sndio
    pkgs.jack2    
    pkgs.zlib    
    pkgs.libedit    
    pkgs.pulseaudio    
    pkgs.alsa-lib    
    pkgs.openal    
    pkgs.kdePackages.qtbase    
    pkgs.kdePackages.qtdeclarative    
    pkgs.kdePackages.qtmultimedia    
    pkgs.kdePackages.qttools    
    pkgs.kdePackages.qtwayland    
    pkgs.xorg.libxcb    
    pkgs.xorg.libXext    
    pkgs.xorg.libX11    
    pkgs.spirv-tools    
    pkgs.vulkan-utility-libraries    
    pkgs.ffmpeg_6-full    
    pkgs.kdePackages.full    
    pkgs.SDL2    
    pkgs.vulkan-validation-layers    
    pkgs.pkg-config    
    ];   
    }

### Docker

https://nixos.wiki/wiki/Docker

https://discourse.nixos.org/t/how-to-run-docker-daemon-from-nix-not-nixos/43413/4

### secrets

https://github.com/Mic92/sops-nix?tab=readme-ov-file

## User

https://devenv.sh/

### vscode 
https://nixos.wiki/wiki/Visual_Studio_Code

https://discourse.nixos.org/t/home-manager-vscode-extension-settings-mutableextensionsdir-false/33878

https://davi.sh/blog/2024/11/nix-vscode/

fonts: https://medium.com/@miffataphlesfkagh/jetbrains-mono-a-special-font-for-developers-bc35443eec2f

### shell
https://github.com/wahtique/dotfiles/blob/main/dot_config/home-manager/shell.nix.tmpl