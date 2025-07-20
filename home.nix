{ config, lib, pkgs, attrs, ... }:
{
  home = {
    inherit (attrs) stateVersion username;
    homeDirectory = "/home/" + attrs.username;
  };
  home.packages = with pkgs; [
    gtrash
    vivaldi
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # Use the packages from our NixOS module.
    package = null;
    portalPackage = null;

    systemd.variables = [ "--all" ];
  };
  xdg.configFile."uwsm/env".source = ''
    ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh
  '';

  programs.nh = {
    enable = true;
    flake = "/home/${attrs.username}/code/nixfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };

  programs.eza = {
    enable = true;

    # Disable shell integration to manage aliases ourselves.
    enableFishIntegration = false;
  };

  programs.fzf = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.fd = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.ripgrep-all = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = let
      eza = lib.concatStringsSep " " [
        "eza"
        "--color=always"
        "--icons=always"
        "--git"
        "--long"
        "--no-permissions"
        "--octal-permissions"
        "--group-directories-first"
        "--classify=always"
        "--hyperlink"
        "--mounts"
        "--follow-symlinks"
        "--smart-group"
        "--time-style=+'%Y-%m-%dx\n%m-%d %H:%M'"
      ];
    in {
      ls = eza;
      la = eza + " --all";
      lt = eza + " --tree";
      lta = eza + " --all --tree";
    };
  };
  # Use fish as the default interactive shell while keeping
  # the login shell POSIX-compliant for compatibility reasons.
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $- == *i* && -z "$NO_FISH_BASH" ]]; then
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };
  # Avoid endlessly looping from bash -> fish -> bash -> ...
  programs.fish.functions.bash = {
    description = "Start bash (without automatically re-entering fish).";
    body = ''
      NO_FISH_BASH="1" command bash $argv
    '';
    wraps = "bash";
  };

  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    installVimSyntax = true;

    settings = {
      theme = "cutiepro";
    };
    themes = {
      cutiepro = {
        palette = [
          "00=#000000"  # ANSI 00 -- black
          "01=#fb5858"  # ANSI 01 -- red
          "02=#e6c56e"  # ANSI 02 -- green
          "03=#ff8358"  # ANSI 03 -- yellow
          "04=#d884ba"  # ANSI 04 -- blue
          "05=#ff40a0"  # ANSI 05 -- magenta
          "06=#55afe6"  # ANSI 06 -- cyan
          "07=#d5d0c9"  # ANSI 07 -- white
          "08=#88847f"  # ANSI 08 -- bright black
          "09=#ff9797"  # ANSI 09 -- bright red
          "10=#ffe08e"  # ANSI 10 -- bright green
          "11=#ffaa77"  # ANSI 11 -- bright yellow
          "12=#ffa2dd"  # ANSI 12 -- bright blue
          "13=#ff6dc4"  # ANSI 13 -- bright magenta
          "14=#a0c3f2"  # ANSI 14 -- bright cyan
          "15=#ffffff"  # ANSI 15 -- bright white
        ];
        background = "#1c1b1a";
        foreground = "#d5d0c9";
        selection-background = "#383838";
        selection-foreground = "#e5a1a3";
        cursor-color = "#e5a1a3";
      };
    };
  };

  programs.kitty = {
    enable = true;
    #font = {
    #  # Use the package from our NixOS module.
    #  package = null;
    #  name = "JetBrainsMono Nerd Font";
    #};
  };

  programs.git = {
    enable = true;
    userName = "jezzy jazmin jumble";
    userEmail = "jezz@jezzy.dev";
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        eol = "lf";
      };
    };
  };

  programs.git.delta = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.vesktop = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        scrolloff = 10;
        scroll-lines = 1;
        line-number = "relative";
        bufferline = "multiple";
        color-modes = true;
        default-line-ending = "lf";
        trim-final-newlines = true;
        trim-trailing-whitespace = true;
      };
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.statusline = {
        left = [
          "mode"
          "spinner"
        ];
        center = [
          "file-name"
          "read-only-indicator"
          "file-modification-indicator"
          "separator"
          "version-control"
        ];
        right = [
          "diagnostics"
          "selections"
          "register"
          "position"
          "position-percentage"
          "file-encoding"
        ];
      };
    };
  };
}
