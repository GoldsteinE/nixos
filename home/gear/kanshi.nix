{ pkgs, ... }: {
  programs.foot.settings.main = {
    # due to lack of support of fractional scaling, we overscale our internal display
    # mitigate it somewhat by making foot font smaller:
    font = pkgs.lib.mkForce "Iosevka Term Nerd Font:size=12";
    # we also make it DPI-aware so external display isn't affected
    dpi-aware = pkgs.lib.mkForce "yes";
  };
  services.kanshi.settings = [
    {
      profile = {
        name = "laptop";
        outputs = [{
          criteria = "eDP-2";
          mode = "2560x1600@165Hz";
          position = "0,0";
          scale = 2.0;
        }];
      };
    }
    {
      profile = {
        name = "workstation";
        outputs = [
          {
            criteria = "eDP-2";
            mode = "2560x1600@165Hz";
            position = "0,0";
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
    }
  ];
}
