{ pkgs, ... }: {
  programs.foot.settings.main = {
    # due to lack of support of fractional scaling, we overscale our internal display
    # mitigate it somewhat by making foot font smaller:
    font = pkgs.lib.mkForce "Iosevka Term Nerd Font:size=12";
    # we also make it DPI-aware so external display isn't affected
    # dpi-aware = pkgs.lib.mkForce "yes";
  };
  services.kanshi.settings = [
    {
      profile = {
        name = "laptop";
        outputs = [{
          criteria = "eDP-1";
          mode = "2560x1600@165Hz";
          position = "0,0";
          scale = 2.0;
          status = "enable";
        }];
      };
    }
    {
      profile = {
        name = "workstation";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "LG Electronics LG ULTRAGEAR+ 408NTRL57206";
            mode = "3840x2160@120Hz";
            position = "0,0";
            scale = 2.0;
          }
          {
            criteria = "Xiaomi Corporation Mi Monitor 2757500034913";
            mode = "2560x1440@165Hz";
            position = "1920,0";
            scale = 2.0;
            transform = "90";
          }
        ];
      };
    }
  ];
}
