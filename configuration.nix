{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    ./kernel/kernel.nix

    "${home-manager}/nixos"
  ];

  # Automatic updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.root.shell = pkgs.zsh;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.runior = {
    isNormalUser = true;
    description = "Jose Rodrigues";
    extraGroups = [
      "audio"
      "networkmanager"
      "wheel"
      "kvm"
      "libvirtd"
      "docker"
    ];
    #packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    #];
  };

  # Home-manager config
  home-manager.useUserPackages = true; # Packages install to /etc/profiles
  home-manager.useGlobalPkgs = true; # Use global package definitions
  home-manager.users.runior = import ./home-manager/home.nix;

  # Bootloader.
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Limit space occupied by generations in boot
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.grub.configurationLimit = 5;

  hardware.enableRedistributableFirmware = true;

  # For Thunderbolt / USB-C support
  services.hardware.bolt.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # make pipewire realtime-capable
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager

    docker
    docker-compose
    lazydocker

    git
    zsh

    nixfmt-rfc-style
    nixd
    nil

    pavucontrol
    alsa-utils
    alsa-firmware
    alsa-ucm-conf
    sof-firmware
    helvum # Great PipeWire graph visualizer

    pciutils
    usbutils
    lshw
    virtualglLib

    unar
    unrar
    p7zip
    appimage-run

    htop
    wget
    curl
    fastfetch

    kdePackages.kate
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.plasma-thunderbolt
  ];

  environment.shells = with pkgs; [ zsh ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # File system config
  # fileSystems."/mnt/ssd1tb" =
  #  { device = "/dev/disk/by-uuid/6aca9d33-261d-4fc1-a117-a95c79186197";
  #    fsType = "btrfs";
  #  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
