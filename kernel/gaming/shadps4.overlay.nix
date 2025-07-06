self: super: {
  shadps4-v07 = super.stdenv.mkDerivation rec {
    pname = "shadps4";
    version = "0.7";

    src = super.fetchgit {
      url = "https://github.com/shadps4-emu/shadPS4.git";
      rev = "v.0.7.0";
      sha256 = "sha256-g55Ob74Yhnnrsv9+fNA1+uTJ0H2nyH5UT4ITHnrGKDo=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = with super; [
      llvmPackages_18.clang
      cmake
      pkg-config
      git
      qt6.wrapQtAppsHook
    ];

    buildInputs = with super; [
      alsa-lib
      libpulseaudio
      openal
      openssl
      zlib
      libedit
      udev
      libevdev
      SDL2
      jack2
      sndio
      qt6.qtbase
      qt6.qttools
      qt6.qtmultimedia
      qt6.qtwayland

      vulkan-headers
      vulkan-utility-libraries
      vulkan-tools

      ffmpeg
      fmt
      glslang
      libxkbcommon
      wayland
      xorg.libxcb
      xorg.xcbutil
      xorg.xcbutilkeysyms
      xorg.xcbutilwm
      sdl3
      stb
      wayland-protocols
      libpng
    ];

    cmakeFlags = [
      "-DENABLE_QT_GUI=ON"
      "-DCMAKE_C_COMPILER=clang"
      "-DCMAKE_CXX_COMPILER=clang++"
      "-DCMAKE_BUILD_TYPE=Release"
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp shadps4 $out/bin/shadps4-v07
    '';

    meta = {
      description = "PS4 emulator - shadps4 v0.7";
      homepage = "https://github.com/shadps4-emu/shadPS4";
      license = super.lib.licenses.gpl2;
      maintainers = [ ];
    };
  };
}
