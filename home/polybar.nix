pkgs: {
  enable = true;
  package = pkgs.polybarFull;

  script = ''
    for m in $(${pkgs.xorg.xrandr}/bin/xrandr --query | ${pkgs.gnugrep}/bin/grep ' connected' | ${pkgs.coreutils}/bin/cut -d' ' -f1); do
        POLYBAR_MONITOR="$m" GITHUB_ACCESS_TOKEN="$(${pkgs.pass}/bin/pass show github-token-polybar)" polybar main &
        POLYBAR_MONITOR="$m" polybar top &
    done
  '';

  settings =
    let
      bar = bottom: modules: {
        inherit bottom modules;
        monitor = "\${env:POLYBAR_MONITOR:}";
        background = "#1d1f21";
        foreground = "#f8f8f2";
        font = [
          "NotoSans-Regular:size=32;2"
          "MaterialIcons:size=28"
          "Font Awesome 6 Free:pixelsize=32;7"
          "Font Awesome 6 Free Solid:pixelsize=32;7"
          "Font Awesome 6 Brands:pixelsize=32;7"
        ];
        padding = {
          left = 0;
          right = 4;
        };
        module-margin = 3;
        fixed-center = false;
        height = 54;
      };
      ws-label = opts: opts // {
        text = "%icon%";
        padding = 4;
      };
    in
    {
      "bar/main" = bar true {
        left = "bspwm";
        right = "gh temperature layout battery date";
      };
      "bar/top" = bar false {
        left = "title";
        right = "network vpn";
      };
      "module/title" = {
        type = "internal/xwindow";
        format-padding = 1;
      };
      "module/bspwm" = {
        type = "internal/bspwm";
        enable-scroll = false;
        pin-workspaces = true;
        label = {
          empty = "";
          focused = ws-label { background = "#293739"; };
          urgent = ws-label { foreground = "#DAD085"; };
          occupied = ws-label { };
        };
        ws-icon = [
          "1;"
          "11;"
          "2;"
          "12;"
          "3;"
          "13;"
          "4;"
          "14;"
          "5;"
          "15;"
          "6;"
          "16;"
          "7;"
          "17;"
          "8;"
          "18;"
        ];
      };
      "module/date" = rec {
        type = "internal/date";
        date = "%a %d.%m.%Y";
        time = "%H:%M";
        date-alt = date;
        time-alt = "%H:%M:%S";
        interval = 1;
        label = "%date% %time%";
      };
      "module/network" = {
        type = "internal/network";
        interface = "wlan0";
        interval = 1;
        label = {
          connected = "  %downspeed% / %upspeed%";
          disconnected = "no network  ";
        };
      };
      "module/vpn" = let s = "${pkgs.systemd}/bin/systemctl"; in
        {
          type = "custom/script";
          exec = "if ${s} status wg-quick-wg0 >/dev/null; then echo 'VPN'; else echo 'direct'; fi";
          click-left = "if ${s} status wg-quick-wg0 >/dev/null; then sudo ${s} stop wg-quick-wg0; else sudo ${s} start wg-quick-wg0; fi";
        };
      "module/battery" = rec {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC0";
        format = {
          charging = "<animation-charging> <label-charging>";
          discharging = "<ramp-capacity> <label-discharging>";
          full = "<ramp-capacity> <label-full>";
        };
        ramp-capacity = [
          ""
          ""
          ""
          ""
          ""
        ];
        animation-charging = ramp-capacity;
        animation-charging-framerate = 750;
      };
      "module/layout" = {
        type = "internal/xkeyboard";
        format = "<label-layout>";
      };
      "module/temperature" = {
        type = "internal/temperature";
        base-temperature = 20;
        warn-temperature = 70;
        label = "  %temperature-c%";
        label-warn = "  %temperature-c%";
        label-warn-foreground = "#e64b0e";
        thermal-zone = 10;
      };
      "module/gh" = {
        type = "internal/github";
        token = "\${env:GITHUB_ACCESS_TOKEN}";
        user = "GoldsteinE";
        empty-notifications = false;
        interval = 60;
        label = "label =  %notifications%";
        format-offline = "";
      };
    };
}
