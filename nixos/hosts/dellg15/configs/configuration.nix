{
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./nvidia.nix
    ./libinput-quirks.nix
    ../scripts
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  boot.kernel.sysctl."vm.swappiness" = 70;
  swapDevices = [
    {
      device = "/swapfile";
      size = 8192; # 8 GiB
    }
  ];

  # Define your hostname
  networking.hostName = "nixos";

  # Allow the user to run nix commands
  nix.settings.trusted-users = [ username ];

  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  # Select internationalization properties.
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

  # Enable the X11 windowing system
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # Set the display configuration
  # window manager should manage this so no need to set it here
  # services.xserver.displayManager.setupCommands = ''
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode 1920x1080 --rate 164.00 --primary
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1  --mode 1920x1080 --rate 120.00 --left-of HDMI-1
  # '';

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "br";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  services.printing.enable = true;

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Dell G15 5515 touchpad configuration
  # Custom udev rules
  services.udev.extraRules = builtins.readFile ./udev-rules/99-dell-g15-touchpad.rules;
  # Touchpad configuration
  services.libinput.touchpad = {
    accelSpeed = "0.6";
    accelProfile = "adaptive";
    naturalScrolling = false;
    tapping = true;
    clickMethod = "clickfinger";
    disableWhileTyping = true;
    additionalOptions = ''
      Option "PalmDetection" "1"
      Option "TappingDragLock" "1"
      Option "Sensitivity" "0.8"
    '';
  };

  # Additional packages for hardware monitoring and management
  environment.systemPackages = with pkgs; [
    lm_sensors
    i2c-tools
    powertop
    glxinfo
    vulkan-tools
    pciutils
    usbutils
  ];
}
