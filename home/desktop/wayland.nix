{ pkgs, inputs, ... }:
let
  naersk = pkgs.callPackage inputs.naersk {};
  persway = naersk.buildPackage inputs.persway;
in
{
  home.packages = with pkgs; [
    rofi-wayland
    wl-clipboard
    slurp
    grim
    eww
    persway
  ];
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraSessionCommands = ''
      export LIBVA_DRIVER_NAME=nvidia
      export XDG_SESSION_TYPE=wayland
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export WLR_NO_HARDWARE_CURSORS=1
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
      keybindings = {
        "${modifier}+Return" = "exec foot";
        "${modifier}+d" = "exec ~/.config/rofi/launchers/misc/launcher.sh";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+alt+h" = "move workspace to output left";
        "${modifier}+alt+j" = "move workspace to output down";
        "${modifier}+alt+k" = "move workspace to output up";
        "${modifier}+alt+l" = "move workspace to output right";
        "${modifier}+z" = "focus parent, layout toggle split, focus child";
      } // (
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
  systemd.user.services = {
    persway = {
      Unit = {
        Description = "Make sway windowing model more palatable";
        WantedBy = "sway-session.target";
      };
      Service.ExecStart = "${persway}/bin/persway daemon -d spiral";
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
    size = 24;
  };
  services.kanshi = {
    enable = true;
    systemdTarget = "sway-session.target";
    profiles = {
      laptop = {
        outputs = [{
          criteria = "eDP-1";
          mode = "3840x2160@60Hz";
          position = "0,0";
          scale = 2.0;
        }];
      };
      workstation = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60Hz";
            position = "0,720";
            scale = 2.0;
          }
          {
            criteria = "HDMI-A-1";
            mode = "2560x1440@60Hz";
            position = "320,0";
            scale = 2.0;
          }
        ];
      };
    };
  };
}
