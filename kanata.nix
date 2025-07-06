{ config, lib, pkgs, ... }:
{
  boot.kernelModules = [ "uinput" ];

  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  systemd.services.kanata-Jezzlappy.serviceConfig = {
    SupplementaryGroups = [ "input" "uinput" ];
  };

  services.kanata = {
    enable = true;
    package = pkgs.kanata-with-cmd;
    keyboards = {
      Jezzlappy = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = ''
          process-unmapped-keys  yes
          danger-enable-cmd      yes
        '';
        config = ''
          (defalias
            qwr  (layer-switch qwerty)
            cmk  (layer-switch colemakdh)
            mod  (tap-dance-eager 400 (
              (layer-while-held fn)
              lctl
            ))
          )

          (defsrc
            esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12   prnt  del   home  end   pgup  pgdn
            `     1     2     3     4     5     6     7     8     9     0     -     =     bspc        nlck  kp/   kp*   kp-
            tab   q     w     e     r     t     y     u     i     o     p     [     ]     \           kp7   kp8   kp9   kp+
            caps  a     s     d     f     g     h     j     k     l     ;     '     ent               kp4   kp5   kp6
            lsft  z     x     c     v     b     n     m     ,     .     /     rsft  up                kp1   kp2   kp3   kprt
            lctl  lmet  lalt                spc                   ralt  rctl  left  down  rght        kp0         kp.
          )

          (deflayer colemakdh
            esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12   prnt  del   home  end   pgup  pgdn
            `     1     2     3     4     5     6     7     8     9     0     -     =     bspc        del   kp/   kp*   kp-
            tab   q     w     f     p     b     j     l     u     y     ;     [     ]     \           kp7   kp8   kp9   kp+
            @mod  a     r     s     t     g     m     n     e     i     o     '     ent               kp4   kp5   kp6
            lsft  x     c     d     v     z     k     h     ,     .     /     rsft  up                kp1   kp2   kp3   kprt
            lctl  lmet  lalt                spc                   ralt  rctl  left  down  rght        kp0         kp.
          )

          (deflayer qwerty
            esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12   prnt  del   home  end   pgup  pgdn
            `     1     2     3     4     5     6     7     8     9     0     -     =     bspc        del   kp/   kp*   kp-
            tab   q     w     e     r     t     y     u     i     o     p     [     ]     \           kp7   kp8   kp9   kp+
            @mod  a     s     d     f     g     h     j     k     l     ;     '     ent               kp4   kp5   kp6
            lsft  z     x     c     v     b     n     m     ,     .     /     rsft  up                kp1   kp2   kp3   kprt
            lctl  lmet  lalt                spc                   ralt  rctl  left  down  rght        kp0         kp.
          )

          (deflayer fn
            lrld  _     _     _     _     _     _     _     _     _     _     _     _     _     slck  _     _     _     _
            _     @qwr  @cmk  _     _     _     _     _     _     _     _     _     _     _           nlck  _     _     _
            home  esc   up    ent   end   _     _     _     _     _     _     _     _     _           _     _     _     _
            _     left  down  rght  pgup  _     left  down  up    rght  _     _     _                 _     _     _
            _     del   bspc  caps  pgdn  _     _     _     _     _     _     _     pgup              _     _     _     _
            _     _     _                    _                    menu  _     home  pgdn  end         _           _
          )
        '';
      };
    };
  };
}
