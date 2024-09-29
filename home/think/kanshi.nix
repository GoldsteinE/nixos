{ ... }: {
  services.kanshi.settings = [
    {
      profile = {
        name = "laptop";
        outputs = [{
          criteria = "eDP-1";
          mode = "3840x2160@60Hz";
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
    }
  ];
}
