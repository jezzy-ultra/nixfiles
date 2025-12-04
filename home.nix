{
  lib,
  pkgs,
  attrs,
  ...
}: {
  home = {
    inherit (attrs) stateVersion username;
    homeDirectory = "/home/" + attrs.username;
  };

  # programs.zed-editor = {
  #   enable = true;
  # };

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
    options = ["--cmd cd"];
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

  programs.ghostty = {
    enable = false;
    installBatSyntax = true;
    installVimSyntax = true;

    settings = {
      minimum-contrast = 1;
    };
  };

  programs.git = {
    enable = true;
    package = "${pkgs.gitFull}";
    settings = {
      credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
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
  };

  programs.fastfetch.enable = true;

  # programs.google-chrome.enable = true;

  programs.starship.enable = true;
  # programs.oh-my-posh.enable = true;

  programs.gh.enable = true;

  dconf.settings = {
    "org/gnome/desktop/applications/terminal" = {
      exec = "kitty";
      # exec-arg = null;
    };
  };

  # home.activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
  #   PATH="${pkgs.chezmoi}/bin:${pkgs.git}/bin:${pkgs.git-lfs}/bin:${pkgs.fish}/bin:''${PATH}"

  #   $DRY_RUN_CMD chezmoi -S ~/src/dotfiles init https://github.com/jezzy-ultra/dotfiles.git
  #   $DRY_RUN_CMD chezmoi update
  #   $DRY_RUN_CMD chezmoi git status
  #   $DRY_RUN_CMD cd ~/src/dotfiles
  #   $DRY_RUN_CMD git remote set-url --push origin git@github.com:jezzy-ultra/dotfiles.git
  #   $DRY_RUN_CMD cd -
  # '';
}
