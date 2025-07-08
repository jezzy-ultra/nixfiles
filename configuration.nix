{ pkgs, attrs, ... }:
{
  imports = [
    ./hardware-configuration.nix  # results of the hardware scan
    ./kanata.nix  # keyboard remapper
  ];

  system.stateVersion = attrs.stateVersion;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  networking.hostName = attrs.hostname;
  #networking.wireless.enable = true;  # wpa_supplicant
  #networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #networking.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  #networking.firewall.enable = false;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.variables = {
    # Improve the font rendering in some applications
    # (e.g. Chromium/Electron).
    FREETYPE_PROPERTIES =
      "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  #services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # Use the example session manager (no others are packaged yet so this is
    # enabled by default, no need to redefine it in your config for now).
    #media-session.enable = true;
  };

  #services.openssh.enable = true;

  # Enable touchpad support (enabled by default in most desktop managers).
  #services.xserver.libinput.enable = true;

  services.printing.enable = true;

  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search <package>
  environment.systemPackages = with pkgs; [  ];

  # Don't forget to set a password with `passwd`.
  users.users.${attrs.username} = {
    isNormalUser = true;
    description = attrs.username;
    extraGroups = [
      "wheel"  # sudo
      "networkmanager"
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];
  };
}
