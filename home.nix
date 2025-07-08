{ lib, pkgs, attrs, ... }:
{
  home.stateVersion = attrs.stateVersion;

  home.username = attrs.username;
  home.homeDirectory = "/home/" + attrs.username;

  home.packages = with pkgs; [
    gnome-tweaks
  ];

  programs.firefox.enable = true;

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

  programs.vesktop.enable = true;

  dconf.settings =
  let
    inherit (lib.hm.gvariant) 
      mkDouble mkTuple mkUint32 mkVariant mkDictionaryEntry;
    weather-locations = [
      (mkVariant (mkTuple [
        (mkUint32 2)
        (mkVariant (mkTuple [
          "Tampere"
          "EFTP"
          true
          [ (mkTuple [
              (mkDouble "1.0719230547509482")
              (mkDouble "0.41160680944423184")
          ])]
          [ (mkTuple [
              (mkDouble "1.0733774899765127")
              (mkDouble "0.41451569734865329")
          ])]
        ]))
      ]))
      (mkVariant (mkTuple [
        (mkUint32 2)
        (mkVariant (mkTuple [
          "Seattle-Tacoma International Airport"
          "KSEA"
          false
          [ (mkTuple [
              (mkDouble "0.82806661159338912")
              (mkDouble "-2.134775231953554")
          ])]
          [ ]
        ]))
      ]))
    ];
  in {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "lv3:menu_switch"
        "compose:ralt"
      ];
    };
    "org/gnome/desktop/background" = {
      picture-uri
        = "file:///run/current-system/sw/share/backgrounds/gnome/fold-l.jxl";
      picture-uri-dark
        = "file:///run/current-system/sw/share/backgrounds/gnome/fold-d.jxl";
      primary-color = "#26a269";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri
        = "file:///run/current-system/sw/share/backgrounds/gnome/fold-l.jxl";
      primary-color = "#26a269";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };
    "org/gnome/desktop/session" = {
      # Automatic screen blank delay
      idle-delay = (mkUint32 900);  # 15 minutes
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = "nothing";
      sleep-inactive-battery-timeout = 1800;  # 30 minutes
    };
    "org/gnome/shell" = {
      last-selected-power-profile = "performance";
    };
    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };
    "org/gnome/shell/weather" = {
      locations = weather-locations;
    };
    "org/gnome/Weather" = {
      locations = weather-locations;
    };
    "org/gnome/clocks" = {
      world-clocks = [
        [ (mkDictionaryEntry [ "location"
          (mkVariant (mkTuple [
            (mkUint32 2)
            (mkVariant (mkTuple [
              "Seattle"
              "KBFI"
              true
              [ (mkTuple [
                  (mkDouble "0.82983133145337307")
                  (mkDouble "-2.134775231953554")
              ])]
              [ (mkTuple [
                  (mkDouble "0.83088509144255718")
                  (mkDouble "-2.135097419733472")
              ])]
            ]))
          ]))
        ])]
      ];
    };
  };
}
