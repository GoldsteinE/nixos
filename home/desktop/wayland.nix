{ pkgs, options, inputs, ... }: {
  home.packages = with pkgs; [
    rofi
    wl-clipboard
    slurp
    grim
    eww
    libnotify
    swaylock
  ];
  wayland.windowManager.sway = {
    enable = true;
    xwayland = false;  # we use xwayland-satellite, as the gods intended
    extraSessionCommands = ''
      export DISPLAY=:0
      if [ "$(whoami)" = "nixbld" ]; then
        export WLR_BACKENDS=headless      # dummy backend for test
      else
        export WLR_BACKENDS=drm,libinput  # suppress sway X11 backend
      fi
      export XDG_SESSION_TYPE=wayland
      export NIXOS_OZONE_WL=1
      export GDK_BACKEND=wayland,x11
      export QT_QPA_PLATFORM='wayland;xcb'
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
    '';
    # Fix `xdg-open` in apps started via `.desktop` files.
    # `xdg-open` searches in `$PATH`, so the full user `$PATH` needs to be available.
    systemd.variables = options.wayland.windowManager.sway.systemd.variables.default ++ [ "PATH" ];
    config = rec {
      modifier = "Mod4";
      input."type:keyboard" = {
        xkb_layout = "us,ru";
        xkb_options = "grp:caps_toggle,lv3:ralt_switch,misc:typo,nbsp:level3";
      };
      input."type:touchpad" = {
        tap = "enabled";
        drag = "enabled";
        drag_lock = "disabled";
        tap_button_map = "lrm";
      };
      keybindings = {
        "${modifier}+Return" = "exec foot";
        "${modifier}+d" = "exec ~/.config/rofi/launchers/misc/launcher.sh";
        "${modifier}+shift+p" = "exec bwp ls | ${pkgs.rofi}/bin/rofi -dmenu -theme ${pkgs.rofi}/share/rofi/themes/android_notification.rasi | xargs bwp | bash -c 'sleep 0.1; xargs ${pkgs.wtype}/bin/wtype -'";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+shift+h" = "mark swap, focus left, swap container with mark swap, focus left, unmark swap";
        "${modifier}+shift+j" = "mark swap, focus down, swap container with mark swap, focus down, unmark swap";
        "${modifier}+shift+k" = "mark swap, focus up, swap container with mark swap, focus up, unmark swap";
        "${modifier}+shift+l" = "mark swap, focus right, swap container with mark swap, focus right, unmark swap";
        "${modifier}+alt+h" = "move workspace to output left";
        "${modifier}+alt+j" = "move workspace to output down";
        "${modifier}+alt+k" = "move workspace to output up";
        "${modifier}+alt+l" = "move workspace to output right";
        "${modifier}+z" = "focus parent, layout toggle split, focus child";
        "${modifier}+q" = "kill";
        "${modifier}+escape" = "exec swaylock --color 000000";
        "Print" =
          let
            visibleWindowsJq = pkgs.writeText "visible-windows.jq" ''
              ..
              | select(.pid? and .visible?)
              | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"
            '';
            printScreen = pkgs.writeShellScript "printscreen.sh" ''
            # systemd-run prevents double-start
            swaymsg -t get_tree \
            | jq -r -f "${visibleWindowsJq}" \
            | systemd-run --quiet --user --scope --unit printscr slurp \
            | grim -g - - \
            | wl-copy --type image/png
            '';
          in
          "exec ${printScreen}";
        "shift+Print" = "exec grim - | wl-copy --type image/png";
        "XF86AudioMicMute" = "exec pamixer --default-source --toggle-mute";
        "XF86AudioPlay" = "exec playerctl play-pause";
        # notification control
        "ctrl+space" = "exec makoctl dismiss";
        "ctrl+shift+space" =
          let
            toggleNotifications = pkgs.writeShellScript "toggle-notifications" ''
              makoctl mode -t off
              if makoctl mode | grep '^off$'; then
                notify-send -c forced "Notifications disabled"
              else
                notify-send -c forced "Notifications enabled"
              fi
            '';
          in
          "exec ${toggleNotifications}";
      } //
      # media keys
      (builtins.mapAttrs
        (key: config:
          let
            script = pkgs.writeShellScript "media-${key}" ''
              ${config.command}
              if ${config.muted}; then
                muted='--category=muted'
              fi
              notify-send \
                --category=forced \
                --hint=int:value:$(${config.value}) \
                --hint=string:x-dunst-stack-tag:${config.tag} \
                $muted \
                --expire-time 1000 \
                "${config.tag}"
            '';
          in
          "exec ${script}")
        {
          "XF86MonBrightnessUp" = {
            command = "light -A 5";
            value = "light";
            muted = "false";
            tag = "Light";
          };
          "XF86MonBrightnessDown" = {
            command = "light -U 5";
            value = "light";
            muted = "false";
            tag = "Light";
          };
          "XF86AudioLowerVolume" = {
            command = "pamixer --decrease 5";
            value = "pamixer --get-volume";
            muted = ''[ "$(pamixer --get-mute)" = true ]'';
            tag = "Volume";
          };
          "XF86AudioRaiseVolume" = {
            command = "pamixer --increase 5";
            value = "pamixer --get-volume";
            muted = ''[ "$(pamixer --get-mute)" = true ]'';
            tag = "Volume";
          };
          "XF86AudioMute" = {
            command = "pamixer --toggle-mute";
            value = "pamixer --get-volume";
            muted = ''[ "$(pamixer --get-mute)" = true ]'';
            tag = "Volume";
          };
        }) // (
        let
          workspaces = {
            "10" = "";
            "11" = "";
            "20" = "";
            "21" = "";
            "30" = "";
            "31" = "";
            "40" = "";
            "41" = "";
            "50" = "";
            "51" = "";
            "60" = "";
            "61" = "";
            "70" = "";
            "71" = "";
            "80" = "";
            "81" = "";
          };
        in
        pkgs.lib.attrsets.concatMapAttrs
          (number: name:
            let
              basicNum = builtins.substring 0 1 number;
              modifierNum = builtins.substring 1 2 number;
              isAlternate = modifierNum == "1";
              baseBind = "${modifier}" + (if isAlternate then "+mod1" else "");
            in
            {
              "${baseBind}+${basicNum}" = "workspace ${number}:${name}";
              "${baseBind}+shift+${basicNum}" = "move window to workspace ${number}:${name}, workspace ${number}:${name}";
            })
          workspaces
      );
    };
  };
  xdg.portal.enable = true;
  xdg.portal.config.common.default = [ "wlr" "gtk" ];
  xdg.portal.config.sway.default = [ "wlr" "gtk" ];
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "text/xml" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "application/vnd.mozilla.xul+xml" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
    };
  };
  systemd.user.services = {
    autotiling = {
      Unit.Description = "Make sway windowing model more palatable";
      Service.ExecStart = "${pkgs.autotiling}/bin/autotiling";
      Install.WantedBy = [ "sway-session.target" ];
    };
    # port of https://github.com/Supreeeme/xwayland-satellite/blob/main/resources/xwayland-satellite.service.
    xwayland-satellite = {
      Unit = {
        Description = "Standalone XWayland server";
        # how is there four different deps?.. I love systemd
        BindsTo = "graphical-session.target";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
        Requisite = "graphical-session.target";
      };
      Service = {
        Type = "notify";
        NotifyAccess = "all";
        # that's a mouthful
        ExecStart = "${inputs.xwayland-satellite.packages.x86_64-linux.xwayland-satellite}/bin/xwayland-satellite";
        StandardOutput = "journal";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Term Nerd Font:size=16";
        dpi-aware = "no";
        resize-delay-ms = 0;
        bold-text-in-bright = "palette-based";
      };
      tweak = {
        box-drawing-base-thickness = 0.015;
      };
      security.osc52 = "copy-enabled";
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Black";
    size = 11;
  };
  # libadwaita is a special little snowflake
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "GoogleDot-Black";
    };
  };
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      progress-color = "#194F6CFF";
      border-color = "#2E3134FF";
      text-color = "#F8F8F2FF";
      background-color = "#1D1F21FF";
      font = "sans 15";
      layer = "overlay";
      padding = "15";
      width = 600;
    };
    extraConfig = ''
      [category=muted]
      progress-color=#3C4C5AFF

      [mode=off]
      invisible=1

      [mode=off category=forced]
      invisible=0
    '';
  };
  # Module doesn't do it automatically for some reason.
  # https://github.com/nix-community/home-manager/issues/2028
  systemd.user.services.mako = {
    Unit.Description = "Mako notification daemon";
    Service.ExecStart = "${pkgs.mako}/bin/mako";
    Install.WantedBy = [ "sway-session.target" ];
  };
  services.kanshi = {
    enable = true;
    systemdTarget = "sway-session.target";
  };
}
