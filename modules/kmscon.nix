{ pkgs, config, ... }: {
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraOptions = let x = config.services.xserver; in "--xkb-layout ${x.xkb.layout} --xkb-options ${x.xkb.options}";
    extraConfig = "font-size=32";
    fonts = [{
      name = "Iosevka Term";
      package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
    }];
  };
}
