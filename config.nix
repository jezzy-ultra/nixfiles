{
  pkgs,
  inputs,
  attrs,
  ...
}: {
  imports = [
    ./hardware.nix # results of the hardware scan
    ./kanata.nix # keyboard remapper
  ];

  system.stateVersion = attrs.stateVersion;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Disable channels since we're using a flake.
  nix.channel.enable = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  networking.hostName = attrs.hostname;

  time.timeZone = "US/Pacific";
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
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    EDITOR = "hx";
  };
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Hint Electron apps to use Wayland.
    NIXOS_OZONE_WL = "1";
  };

  programs.nh = {
    enable = true;
    flake = "/home/${attrs.username}/src/nixfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };

  # services.displayManager.cosmic-greeter.enable = true;
  # services.desktopManager.cosmic.enable = true;
  # services.flatpak.enable = true;

  # services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-browser-connector.enable = true;
  services.geoclue2.enable = true;

  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;

    # FIXME: fix audio crackling in Deltarune...?
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 500;
        "default.clock.min-quantum" = 500;
        "default.clock.max-quantum" = 500;
      };
    };
  };

  # services.openssh.enable = true;

  # services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search <package>
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
    gcc
    chezmoi
    unzip
    wl-clipboard
    lldb
    gnome-tweaks
    # claude-code
    wezterm
    nixd
    simple-completion-language-server
    nixfmt
    xclip
    nodejs
    pkg-config
    openssl
    typescript-language-server
    superhtml
    # zed-editor-fhs
    python3
    mpls
    deno
    lemminx
    biome
    socat
    bubblewrap
    kitty
    gtrash
    vivaldi
    rustup
    tombi
    # taplo
    fish-lsp
    marksman
    yaml-language-server
    vscode-langservers-extracted
    dprint
    dprint-plugins.dprint-plugin-markdown
    xdg-terminal-exec
    carapace
    web-ext
    alejandra
    graphviz
    tree
    xxd
  ];

  programs.direnv = {
    enable = true;
    # silent = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  # programs.zed = {
  #   enable = true;
  #   package = pkgs.zed-editor-fhs.override {
  #     shell = "${pkgs.bashInteractive}/bin/bash";
  #     extraInstallCommands = ''
  #       mkdir -p $out/etc
  #       echo "${pkgs.bashInteractive}/bin/bash" > $out/etc/shells
  #     '';
  #   };
  # };

  programs.dconf.enable = true;

  programs.fish = {
    enable = true;
  };

  programs.command-not-found.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # Don't forget to set a password with `passwd`.
  users.users.${attrs.username} = {
    isNormalUser = true;
    description = attrs.username;
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hmbackup";
    users.${attrs.username} = ./home.nix;
    extraSpecialArgs = {inherit attrs;};
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];
  };
}
