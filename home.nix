{ pkgs, attrs, ... }:
{
  home.stateVersion = attrs.stateVersion;

  home.username = attrs.username;
  home.homeDirectory = "/home/" + attrs.username;

  home.packages = with pkgs; [ ];

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
  programs.git-credential-oauth.enable = true;

  programs.firefox.enable = true;
}
