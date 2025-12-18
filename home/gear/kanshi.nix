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
          criteria = "BOE 0x0BC9 Unknown";
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
            criteria = "BOE 0x0BC9 Unknown";
            status = "disable";
          }
          {
            criteria = "LG Electronics LG ULTRAGEAR+ 408NTRL57206";
            mode = "3840x2160";
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
    {
      profile = {
        name = "workstation-small";
        outputs = [
          {
            criteria = "BOE 0x0BC9 Unknown";
            status = "disable";
          }
          {
            criteria = "LG Electronics LG ULTRAGEAR+ 408NTRL57206";
            mode = "3840x2160";
            position = "0,0";
            scale = 2.0;
          }
        ];
      };
    }
  ];
}
