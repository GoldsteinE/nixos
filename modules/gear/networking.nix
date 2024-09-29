{ ... }: {
  networking = {
    hostName = "gear";
    dhcpcd.wait = "if-carrier-up";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  # See https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
