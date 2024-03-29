{ pkgs, root, ... }: {
  xsession = {
    enable = true;
    windowManager.bspwm = {
      enable = true;
      monitors.any = pkgs.lib.splitString "," "1,11,2,12,3,13,4,14,5,15,6,16,7,17,8,18";
      settings = {
        focus_follows_pointer = true;
        borderless_monocle = true;
        gapless_monocle = true;
        single_monocle = true;
        border_width = 0;
        window_gap = 20;
      };
      startupPrograms = [
        "feh --bg-scale ~/.config/bspwm/desktop.jpg"
        "systemctl --user start yubikey-touch-detector.service"
        "systemctl --user start pass-secret-service.service"
        "systemctl --user start wired.service"
      ];

      rules."Peek:peek".state = "floating";
    };
  };
  services.sxhkd = {
    enable = true;
    extraConfig = builtins.readFile "${root}/dotfiles/.config/sxhkd/sxhkdrc";
  };
}
