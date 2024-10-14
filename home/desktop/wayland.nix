{ pkgs, ... }: {
  home.packages = with pkgs; [
    rofi-wayland
    wl-clipboard
    slurp
    grim
    eww
    libnotify
    swaylock
    xdg-utils
  ];
  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export NIXOS_OZONE_WL=1
      export GDK_BACKEND=wayland,x11
      export QT_QPA_PLATFORM='wayland;xcb'
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
    '';
    config = rec {
      modifier = "Mod4";
      input."type:keyboard" = {
        xkb_layout = "us,ru";
        xkb_options = "grp:caps_toggle,lv3:ralt_switch,misc:typo,nbsp:level3";
      };
      input."type:touchpad" = {
        tap = "enabled";
        drag = "enabled";
        tap_button_map = "lrm";
      };
      keybindings = {
        "${modifier}+Return" = "exec foot";
        "${modifier}+d" = "exec ~/.config/rofi/launchers/misc/launcher.sh";
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
            "21" = "";
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
  xdg.portal.config.common.default = "*";
  xdg.portal.config.sway.default = "*";
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
  ];
  systemd.user.services = {
    autotiling = {
      Unit.Description = "Make sway windowing model more palatable";
      Service.ExecStart = "${pkgs.autotiling}/bin/autotiling";
      Install.WantedBy = [ "sway-session.target" ];
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Term Nerd Font:size=16";
        dpi-aware = "no";
        resize-delay-ms = 0;
      };
      tweak = {
        box-drawing-base-thickness = 0.015;
      };
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 12;
  };
  services.mako = {
    enable = true;
    font = "sans 15";
    padding = "15";
    width = 600;
    textColor = "#F8F8F2FF";
    borderColor = "#2E3134FF";
    progressColor = "#194F6CFF";
    backgroundColor = "#1D1F21FF";
    defaultTimeout = 5000;
    layer = "overlay";
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
