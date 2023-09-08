{ ... }: {
  networking = {
    hostName = "think";
    dhcpcd.wait = "if-carrier-up";
    hosts = {
      "127.0.0.1" = [
        "requests.test"
      ];
      "163.172.167.207" = [
        "bt.t-ru.org"
        "bt2.t-ru.org"
        "bt3.t-ru.org"
        "bt4.t-ru.org"
      ];
    };
    networkmanager.enable = true;
    firewall.allowedUDPPorts = [ 51820 ];

    wg-quick.interfaces.wg0 = {
      autostart = true;
      address = [ "10.252.40.22/32" ];
      mtu = 1450;
      privateKeyFile = "/var/secrets/wvpn.key";

      peers = [{
        publicKey = "PilTIN0d7Pt1Y+5vRRTv+8nvvSVSrI3CeZBh2eKx2Ao=";
        allowedIPs = [ "95.217.119.142/32" ];
        endpoint = "128.140.82.87:51840";
        persistentKeepalive = 15;
        presharedKeyFile = "/var/secrets/wvpn-preshared.key";
      }];
    };
  };
  systemd.services.openvpn-work.wants = [ "wg-quick-wg0.service" ];
}
