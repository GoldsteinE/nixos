{ pkgs, config, ... }: {
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraOptions = let x = config.services.xserver; in "--xkb-layout ${x.layout} --xkb-options ${x.xkbOptions}";
    extraConfig = "font-size=32";
    fonts = [{
      name = "Iosevka Term";
      package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
    }];
  };
}
