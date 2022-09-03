{ pkgs, inputs, config, ... }: {
  services = {
    kmscon = {
      enable = true;
      hwRender = true;
      extraOptions = let x = config.services.xserver; in "--xkb-layout ${x.layout} --xkb-options ${x.xkbOptions}";
      extraConfig = "font-size=32";
      fonts = [{
        name = "Iosevka Term";
        package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
      }];
    };
  };

  virtualisation.podman.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 7643 80 443 53 5443 19423 ];
    allowedUDPPorts = [ 53 43211 19423 51820 ];
    interfaces.wg0.allowedTCPPorts = [ 10600 10601 ];
  };
}
