{ root, ... }: {
  classified.files = {
    "work-vpn.ovpn".encrypted = "${root}/secrets/work-vpn.ovpn";
    "work-vpn-ovpn.pass".encrypted = "${root}/secrets/work-vpn-ovpn.pass";
    "work-vpn-wg.key".encrypted = "${root}/secrets/work-vpn-wg.key";
    "work-vpn-wg-preshared.key".encrypted = "${root}/secrets/work-vpn-wg-preshared.key";
  };
  services.openvpn.servers.work = {
    config = "config /var/secrets/work-vpn.ovpn";
    updateResolvConf = true;
  };
  networking.wg-quick.interfaces.wg0 = {
    autostart = true;
    address = [ "10.252.40.22/32" ];
    mtu = 1450;
    privateKeyFile = "/var/secrets/work-vpn-wg.key";

    peers = [{
      publicKey = "PilTIN0d7Pt1Y+5vRRTv+8nvvSVSrI3CeZBh2eKx2Ao=";
      allowedIPs = [ "95.217.119.142/32" ];
      endpoint = "128.140.82.87:51840";
      persistentKeepalive = 15;
      presharedKeyFile = "/var/secrets/work-vpn-wg-preshared.key";
    }];
  };
  systemd.services.openvpn-work.wants = [ "wg-quick-wg0.service" ];
}
