{ ... }: {
  networking = {
    hostName = "think";
    dhcpcd.wait = "if-carrier-up";
    networkmanager.enable = true;
  };

  # See https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
