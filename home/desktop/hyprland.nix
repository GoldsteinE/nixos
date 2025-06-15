{ lib, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    # enableNvidiaPatches = true;
    settings = {
      general = {
        border_size = 0;
        gaps_out = 5;
      };
      "$mod" = "SUPER";
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
      bind =
        let
          genWorkspaceBinds = ws: builtins.concatLists (map
            (w: [
              ("$mod," + toString (w) + ",workspace," + toString (w))
              ("super_shift," + toString (w) + ",movetoworkspace," + toString (w))
              ("super_alt," + toString (w) + ",workspace,1" + toString (w))
              ("super_alt_shift," + toString (w) + ",movetoworkspace,1" + toString (w))
            ])
            ws);
        in
        [
          "$mod,return,exec,foot"
          "$mod,d,exec,~/.config/rofi/launchers/misc/launcher.sh"
          "super_shift,q,killactive,"
          "super_shift,space,togglefloating"
          "$mod,f,fullscreen"
          "$mod,equal,splitratio,+0.05"
          "$mod,minus,splitratio,-0.05"
          "$mod,h,movefocus,l"
          "$mod,j,movefocus,d"
          "$mod,k,movefocus,u"
          "$mod,l,movefocus,r"
          "super_shift,h,swapwindow,l"
          "super_shift,j,swapwindow,d"
          "super_shift,k,swapwindow,u"
          "super_shift,l,swapwindow,r"
        ] ++ genWorkspaceBinds (lib.range 1 8);
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        "NIXOS_OZONE_WL,1"
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
      ];
      xwayland.force_zero_scaling = true;
      animation = [
        "workspaces,0,1,default"
        "windows,0,1,default"
        "fade,0"
      ];
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:caps_toggle,lv3:ralt_switch,misc:typo,nbsp:level3";
      };
      dwindle = {
        no_gaps_when_only = 1;
        preserve_split = true;
        force_split = 2;
      };
    };
  };
  home.packages = with pkgs; [
    rofi-wayland
    wl-clipboard
    slurp
    grim
    eww
  ];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Term Nerd Font:size=16";
        dpi-aware = "no";
      };
      tweak = {
        box-drawing-base-thickness = 0.015;
      };
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Black";
    size = 24;
  };
}
