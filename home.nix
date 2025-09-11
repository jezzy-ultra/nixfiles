{ config, lib, pkgs, attrs, ... }:
{
  home = {
    inherit (attrs) stateVersion username;
    homeDirectory = "/home/" + attrs.username;
  };
  home.packages = with pkgs; [
    kitty
    gtrash
    vivaldi
    rustup
    tombi
    fish-lsp
    marksman
    yaml-language-server
    vscode-langservers-extracted
    dprint
    dprint-plugins.dprint-plugin-markdown
    xdg-terminal-exec
    carapace
    web-ext
  ];

  # wayland.windowManager.hyprland = {
  #   enable = true;

  #   # Use the packages from our NixOS module.
  #   package = null;
  #   portalPackage = null;

  #   systemd.variables = [ "--all" ];
  # };
  # xdg.configFile."uwsm/env".source = ''
  #   ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh
  # '';

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
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
  };

  # programs.fish = {
  #  enable = true;
  #   shellAbbrs = {
  #     tp = "gtrash put";
  #   };
  #   shellAliases = let
  #     eza = lib.concatStringsSep " " [
  #       "eza"
  #       "--color=always"
  #       "--icons=always"
  #       "--git"
  #       "--long"
  #       "--no-permissions"
  #       "--octal-permissions"
  #       "--group-directories-first"
  #       "--classify=always"
  #       "--hyperlink"
  #       "--mounts"
  #       "--follow-symlinks"
  #       "--smart-group"
  #       "--time-style=+'%Y-%m-%dx\n%m-%d %H:%M'"
  #     ];
  #   in {
  #     ls = eza;
  #     la = eza + " --all";
  #     lt = eza + " --tree";
  #     lta = eza + " --all --tree";
  #     lg = eza + " --git-repos";
  #     # FIXME
  #     rm = "echo 'Are you sure? Use `command rm` to permanently delete something.'";
  #   };
  # };
  # Use fish as the default interactive shell while keeping
  # the login shell POSIX-compliant for compatibility reasons.
  # programs.bash = {
  #   enable = true;
  #   initExtra = ''
  #     if [[ $- == *i* && -z "$NO_FISH_BASH" ]]; then
  #       exec ${pkgs.fish}/bin/fish
  #     fi
  #   '';
  # };
  # # Avoid endlessly looping from bash -> fish -> bash -> ...
  # programs.fish.functions.bash = {
  #   description = "Start bash (without automatically re-entering fish).";
  #   body = ''
  #     NO_FISH_BASH="1" command bash $argv
  #   '';
  #   wraps = "bash";
  # };

  programs.ghostty = {
    enable = false;
    installBatSyntax = true;
    installVimSyntax = true;

    settings = {
      # theme = "cutiepro";
      minimum-contrast = 1;
    };
    # themes = {
    #   cutiepro = {
    #     palette = [
    #       "00=#181716"  # blackboard / black
    #       "08=#88847f"  # elephant / bright black
    #       "01=#f56e7f"  # rose / red
    #       "09=#f56e7f"  # rose / bright red
    #       "02=#e5a1a3"  # cherry blossom / green
    #       "10=#e5a1a3"  # cherry blossom / bright green
    #       "03=#bec975"  # sour apple / yellow
    #       "11=#bec975"  # sour apple / bright yellow
    #       "04=#f3b061"  # creamsicle / blue
    #       "12=#f3b061"  # creamsicle / bright blue
    #       "05=#c69ed1"  # lilac / magenta
    #       "13=#c69ed1"  # lilac / bright magenta
    #       "06=#80c5de"  # sky / cyan
    #       "14=#80c5de"  # sky / bright cyan
    #       "07=#d5d0c9"  # chalk / white
    #       "15=#d5d0c9"  # chalk / bright white
    #     ];
    #     background = "#181716";  # blackboard
    #     foreground = "#e8d6a7";  # honeycomb
    #     selection-background = "#e8d6a7";  # honeycomb
    #     selection-foreground = "#181716";  # blackboard
    #     cursor-color = "#e5a1a3";  # cherry blossom
    #   };
    # };
  };

  # programs.kitty = {
  #   enable = true;
  #   font = {
  #     # Use the package from our NixOS module.
  #     package = null;
  #     name = "JetBrainsMono Nerd Font";
  #     size = 12;
  #   };
  # };

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
      push = {
        default = "current";
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
    # settings = {
    #   theme = "catppuccin_macchiato";
    #   editor = {
    #     scrolloff = 10;
    #     cursorline = true;
    #     scroll-lines = 1;
    #     line-number = "relative";
    #     bufferline = "multiple";
    #     color-modes = true;
    #     default-line-ending = "lf";
    #     trim-final-newlines = true;
    #     trim-trailing-whitespace = true;
    #   };
    #   editor.cursor-shape = {
    #     normal = "block";
    #     insert = "bar";
    #     select = "underline";
    #   };
    #   editor.statusline = {
    #     left = [
    #       "mode"
    #       "spinner"
    #     ];
    #     center = [
    #       "file-name"
    #       "read-only-indicator"
    #       "file-modification-indicator"
    #       "separator"
    #       "version-control"
    #     ];
    #     right = [
    #       "diagnostics"
    #       "selections"
    #       "register"
    #       "position"
    #       "position-percentage"
    #       "file-encoding"
    #     ];
    #   };
    # };
  };
  # xdg.configFile."helix/config.toml".source = ./helix/config.toml;
  # xdg.configFile."helix/themes/cutiepro.toml".source =
  #   config.lib.file.mkOutOfStoreSymlink
  #     "${config.home.homeDirectory}/code/cutiepro/helix/cutiepro.toml";
  # xdg.configFile."helix/languages.toml".source = ./helix/languages.toml;

  # xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
  # xdg.configFile."kitty/themes/cutiepro.conf".source =
  #   config.lib.file.mkOutOfStoreSymlink
  #     "${config.home.homeDirectory}/code/cutiepro/kitty/cutiepro.conf";

  programs.fastfetch.enable = true;

  programs.google-chrome.enable = true;

  programs.starship.enable = true;
  programs.oh-my-posh.enable = true;

  programs.gh.enable = true;

  dconf.settings = {
    "org/gnome/desktop/applications/terminal" = {
      exec = "kitty";
      exec-arg = null;
    };
  };

  home.activation.chezmoi = lib.hm.dag.entryAfter ["installPackages"] ''
    PATH="${pkgs.chezmoi}/bin:${pkgs.git}/bin:${pkgs.git-lfs}/bin:${pkgs.fish}/bin:''${PATH}"

    $DRY_RUN_CMD chezmoi -S ~/code/dotfiles init https://github.com/jezzy-ultra/dotfiles.git
    $DRY_RUN_CMD chezmoi update
    $DRY_RUN_CMD chezmoi git status
    $DRY_RUN_CMD cd ~/code/dotfiles
    $DRY_RUN_CMD git remote set-url --push origin git@github.com:jezzy-ultra/dotfiles.git
    $DRY_RUN_CMD cd -

    $DRY_RUN_CMD fish -c fisher update
  '';
}
